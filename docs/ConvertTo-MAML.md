---
CommandName: Get-MAML
Parameters: 
  - Name: Name
    Type: System.String[]
    Aliases: 
    
  - Name: Module
    Type: System.String[]
    Aliases: 
    
  - Name: CommandInfo
    Type: System.Management.Automation.CommandInfo[]
    Aliases: 
    
  - Name: Compact
    Type: System.Management.Automation.SwitchParameter
    Aliases: 
    
  - Name: XML
    Type: System.Management.Automation.SwitchParameter
    Aliases: 
    
  - Name: NoVersion
    Type: System.Management.Automation.SwitchParameter
    Aliases: 
    - Unversioned

Description: |
  
  Gets help for a given command, as MAML (Microsoft Assistance Markup Language) xml.
  
  
  
Synopsis: Gets MAML help
---
Get-MAML
--------
### Synopsis
Gets MAML help

---
### Description

Gets help for a given command, as MAML (Microsoft Assistance Markup Language) xml.

---
### Related Links
* [Get-Help](https://docs.microsoft.com/powershell/module/Microsoft.PowerShell.Core/Get-Help)



* [Save-MAML](Save-MAML.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-MAML -Name Get-MAML
```

#### EXAMPLE 2
```PowerShell
Get-Command Get-MAML | Get-MAML
```

#### EXAMPLE 3
```PowerShell
Get-MAML -Name Get-MAML -Compact
```

#### EXAMPLE 4
```PowerShell
Get-MAML -Name Get-MAML -XML
```

---
### Parameters
#### **Name**

The name of or more commands.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Module**

The name of one or more modules.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **CommandInfo**

The CommandInfo object (returned from Get-Command).



> **Type**: ```[CommandInfo[]]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByValue)



---
#### **Compact**

If set, the generated MAML will be compact (no extra whitespace or indentation).  If not set, the MAML will be indented.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **XML**

If set, will return the MAML as an XmlDocument.  The default is to return the MAML as a string.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **NoVersion**

If set, the generate MAML will not contain a version number.  
This slightly reduces the size of the MAML file, and reduces the rate of changes in the MAML file.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Inputs
[Management.Automation.CommandInfo]
Accepts a command

---
### Outputs
* [String]
The MAML, as a String.  This is the default.


* [Xml]
The MAML, as an XmlDocument (when -XML is passed in)




---
### Syntax
```PowerShell
Get-MAML [-Compact] [-XML] [-NoVersion] [<CommonParameters>]
```
```PowerShell
Get-MAML [[-Name] <String[]>] [-Compact] [-XML] [-NoVersion] [<CommonParameters>]
```
```PowerShell
Get-MAML [-Module <String[]>] [-Compact] [-XML] [-NoVersion] [<CommonParameters>]
```
```PowerShell
Get-MAML -CommandInfo <CommandInfo[]> [-Compact] [-XML] [-NoVersion] [<CommonParameters>]
```
---
