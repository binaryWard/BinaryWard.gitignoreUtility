[CmdletBinding()]
param
(
  [Parameter(Mandatory = $True, ValueFromPipeline = $true)]
  [string[]]$TemplateFilePath,
  [string]$OutPath = (Get-Location)
)

BEGIN {
  function Add-TemplateContent(
    [Parameter(Mandatory = $True)][string]$filePath
    , [Parameter(Mandatory = $True)][string]$gitIgnoreFile
  ) {
    $private:templateName = [System.IO.FileInfo]::new($filePath).Name
    Add-Content -Path $gitIgnoreFile -Value "`r`n#####################################################`r`n## $private:templateName`r`n#####################################################`r`n"
    Get-Content -Path $filePath | Add-Content -Path $gitIgnoreFile
  }

  Set-Variable -Name GITIGNORE_FILENAME -Value ".gitignore" -Option Constant
  $private:gitignoreFilePath = Join-Path -Path $OutPath -ChildPath $GITIGNORE_FILENAME
  Set-Content -Path $private:gitignoreFilePath -Value "# auto generated: $([System.DateTime]::UtcNow.ToString("u"))"
}

PROCESS {
  foreach ($private:filePath in $TemplateFilePath) {
    Add-TemplateContent -filePath $private:filePath -gitIgnoreFile $private:gitignoreFilePath
  }
}

END {
  Write-Output ([System.IO.FileInfo]::new($private:gitignoreFilePath))
 }