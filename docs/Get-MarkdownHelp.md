
Get-MarkdownHelp
----------------
### Synopsis
Gets Markdown Help

---
### Description

Gets Help for a given command, in Markdown

---
### Related Links
* [Save-MarkdownHelp](Save-MarkdownHelp.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Get-MarkdownHelp Get-Help
```

---
### Parameters
#### **Name**

The name of the specified command or concept.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |1      |true (ByPropertyName)|
---
#### **Wiki**

If set, will generate a markdown wiki.  Links will be relative to the current path, and will not include the .md extensions



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **GitHubDocRoot**

If set, will interlink documentation as if it were for GitHub pages, beneath a given directory



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[String]```|false   |named  |false        |
---
#### **Rename**

If provided, will rename the help topic before getting markdown.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |named  |true (ByPropertyName)|
---
#### **SectionOrder**

The order of the sections.
If not provided, this will be the order they are defined in the formatter.



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |named  |true (ByPropertyName)|
---
#### **NoValidValueEnumeration**

If set, will not enumerate valid values and enums of parameters.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
### Outputs
[string]

The documentation for a single command, in Markdown.


---
### Syntax
```PowerShell
Get-MarkdownHelp [[-Name] <String>] [-Wiki] [-GitHubDocRoot <String>] [-Rename <String>] [-SectionOrder <String[]>] [-NoValidValueEnumeration] [<CommonParameters>]
```
---

