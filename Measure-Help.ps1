function Measure-Help
{
    <#
    .Synopsis
        Determines the percentage of documentation
    .Description
        Determines the percentage of documentation in a given script
    .Example
        dir -Filter *.ps1 | Measure-Help 
    .EXAMPLE
        Get-Command -Module HelpOut | Measure-Help
    .Example
        Measure-Help {
            # This script has some documentation, and then a bunch of code that literally does nothing
            $null = $null # The null equivilancy 
            $null * 500 # x times nothing is still nothing
            $null / 100 # Nothing out of 100             
        } | Select-Object -ExpandProperty PercentageDocumented
    .LINK
        Get-Help
    #>    
    [CmdletBinding(DefaultParameterSetName='FilePath')]
    param(
    # The path to the file
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,Position=0,ParameterSetName='FilePath')]
    [Alias('Fullname')]
    [string]
    $FilePath,

    # A PowerShell script block
    [Parameter(Mandatory,ParameterSetName='ScriptBlock',ValueFromPipelineByPropertyName)]
    [ScriptBlock]
    $ScriptBlock,

    # The name of the script being measured.
    [Parameter(ParameterSetName='ScriptBlock',ValueFromPipelineByPropertyName)]
    [string]
    $Name
    )

    begin {
        $fileList = New-Object Collections.ArrayList
        $ScriptBlockList = New-Object Collections.ArrayList
        $NameList = New-Object Collections.ArrayList

        filter OutputDocRatio {
            $scriptText = $_
            $scriptToken = [Management.Automation.PSParser]::Tokenize($scriptText, [ref]$null)

            # A quick tight little loop to sum
            # the lengths of different types in one 
            # pass (Group-Object would work, but would be slower)
            $commentLength= 0
            $otherLength = 0
            $blockCommentLength = 0
            $inlineCommentLength  = 0
            $blockComments   = @()
            $inlineComments  = @()
            $totalLength = 0 
            foreach ($token in $ScriptToken) {
                $totalLength+=$token.Length
                if ($token.Type -eq 'Comment') {
                    if ($token.Content.StartsWith('<#')) {
                        $blockComments+=$token
                        $blockCommentLength += $token.Length
                    } else {
                        $inlineComments+=$token
                        $inlineCommentLength += $token.Length
                    }
                    $commentLength+=$token.Length
                } else {
                    $otherLength+=$token.Length
                }
            }
        
            # The percent is easy to calculate
            $percent =$commentLength * 100 / $totalLength
            @{
                CommentLength       = $commentLength
                TokenLength         = $otherLength
                CommentPercent      = $percent
                BlockComments       = $blockComments
                BlockCommentLength  = $blockCommentLength
                InlineComments      = $inlineComments
                InlineCommentLength = $inlineCommentLength
            }
            
        }        
    }

    process {
        if ($PSCmdlet.ParameterSetName -eq 'FilePath') {
            $fileList.AddRange(@($FilePath))
        } elseif ($PSCmdlet.ParameterSetName -eq 'ScriptBlock') {
            $null = $ScriptBlockList.Add($ScriptBlock)
            $null = $NameList.Add($Name)
        }
    }

    end {
        if ($ScriptBlockList.Count) {
            $scriptBlockIndex =0 
            foreach ($sb in $ScriptBlockList) {
                [PSCustomObject]([Ordered]@{
                    PSTypeName = "Documentation.Percentage"
                    Name = $NameList[$scriptBlockIndex]
                    ScriptBlock = $sb
                } + ($sb | OutputDocRatio))
                $scriptBlockIndex++
            }
        }

        if ($fileList.Count) {
            foreach ($f in $fileList) {
                $RF = $ExecutionContext.SessionState.Path.GetResolvedPSPathFromPSPath($F)
                if (-not $rf) { continue }
                $fileItem = Get-Item -LiteralPath $RF
                $sb = $null
                $sb = try {
                    [ScriptBlock]::Create([IO.File]::ReadAllText($RF))
                } catch {
                    $null 
                }

                if ($sb) {
                    [PSCustomObject]([Ordered]@{
                        PSTypeName = "File.Documentation.Percentage"
                        Name = $fileItem.Name
                        FilePath = "$rf"
                        ScriptBlock = $sb
                    } + ($sb | OutputDocRatio))
                }
            }
        }
    }
}