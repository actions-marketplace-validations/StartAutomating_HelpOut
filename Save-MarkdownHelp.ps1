function Save-MarkdownHelp
{
    <#
    .Synopsis
        Saves a Module's Markdown Help
    .Description
        Get markdown help for each command in a module and saves it to the appropriate location.
    .Link
        Get-MarkdownHelp
    .Example        
        Save-MarkdownHelp -Module HelpOut  # Save Markdown to HelpOut/docs
    .Example
        Save-MarkdownHelp -Module HelpOut -Wiki # Save Markdown to ../HelpOut.wiki
    #>
    param(
    # The name of one or more modules.
    [Parameter(ParameterSetName='ByModule',ValueFromPipelineByPropertyName=$true)]
    [string[]]
    $Module,

    # The output path.  
    # If not provided, will be assumed to be the "docs" folder of a given module (unless -Wiki is specified)
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $OutputPath,

    # If set, will interlink documentation as if it were a wiki.  Implied when -OutputPath contains 'wiki'.
    # If provided without -OutputPath, will assume that a wiki resides in a sibling directory of the module.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Wiki
    )

    begin {
        # First, let's cache a reference to Get-MarkdownHelp
        $GetMarkdownHelp = 
            if ($MyInvocation.MyCommand.ScriptBlock.Module) {
                $MyInvocation.MyCommand.ScriptBlock.Module.ExportedCommands['Get-MarkdownHelp']
            } else {
                $ExecutionContext.SessionState.InvokeCommand.GetCommand('Get-MarkdownHelp', 'Function')
            }        
    }

    process {

        #region Save the Markdowns
        foreach ($m in $Module) { # Walk thru the list of module names.            
            if ($t -gt 1) {
                $c++
                Write-Progress 'Saving Markdown' $m -PercentComplete $p  -Id $id
            }

            $theModule = Get-Module $m # Find the module
            if (-not $theModule) { continue } # (continue if we couldn't).

            if (-not $psBoundParameters.OutputPath) {
                $theModuleRoot = $theModule | Split-Path # Find the module's root,
                $OutputPath = 
                    if ($Wiki) {
                        Split-Path $theModuleRoot | Join-Path -ChildPath "$($theModule.Name).wiki"
                    } else {
                        Join-Path $theModuleRoot "docs"                        
                    }                
            }
            
            if (-not (Test-Path $OutputPath)) {
                $null = New-Item -ItemType Directory -Path $OutputPath
            }

            $outputPathItem = Get-Item $OutputPath
            if ($outputPathItem -isnot [IO.DirectoryInfo]) {
                Write-Error "-OutputPath '$outputPath' must point to a directory"
                return
            }

            $myHelpParams = @{}
            if ($wiki) { $myHelpParams.Wiki = $true}
            else { $myHelpParams.GitHubDocRoot = $OutputPath | Split-Path}            

            foreach ($cmd in $theModule.ExportedCommands.Values) {
                $docOutputPath = Join-Path $outputPath ($cmd.Name + '.md')
                $getMarkdownHelpSplat = @{Name="$cmd"}
                if ($Wiki) { $getMarkdownHelpSplat.Wiki = $Wiki}
                else { $getMarkdownHelpSplat.GitHubDocRoot = "$($outputPath|Split-Path -Leaf)"}
                & $GetMarkdownHelp @getMarkdownHelpSplat| Set-Content -Path $docOutputPath -Encoding utf8
            }
         }

        if ($t -gt 1) {
            Write-Progress 'Saving Markdown' 'Complete' -Completed -Id $id
        }
        #endregion Save the Markdowns
    }
}
