# BinaryWard gitignore Utility

Create a new .gitignore file from multiple .gitignore templates.  The templates can be from GitHub/gitignore templates and local file system custom .gitignore files.

The New-GitIgnore.ps1 is given the file paths of the templates used to create the .gitignore file.

The Get-GitHubGitIngoreTemplate.ps1 will download the git .ignore templates specified in the command line.  The complete filename must be specified.  
The Add-GitIgnoreTemplate allows the insertion of git .ignore templates in-line on the command-line pipe.

## Example 1

Create a new .gitignore using GitHub templates

```powershell
.\Get-GitHubGitIngoreTemplate.ps1 -TemplateName "Node.gitignore", "VisualStudioCode.gitignore", "Linux.gitignore", "macOS.gitignore", "Windows.gitignore" -OutPath "D:\GitHub_gitignore_Template" | .\New-GitIgnore.ps1 -OutPath "D:\GitHub_gitignore_Template"
```

## Example 2

Create a new .gitignore using GitHub templates and a custom .gitignore template.

```powershell
.\Get-GitHubGitIngoreTemplate.ps1 -TemplateName "Node.gitignore", "VisualStudioCode.gitignore", "Windows.gitignore" -OutPath "D:\GitHub_gitignore_Template" | .\Add-GitIgnoreTemplate.ps1 -FilePath "D:\GitHub_gitignore_Template\custom.gitignore" | .\New-GitIgnore.ps1 -OutPath "D:\GitHub_gitignore_Template"
```
