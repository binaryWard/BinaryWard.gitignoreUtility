[CmdletBinding()]
param
(
  [Parameter(Mandatory = $True, ValueFromPipeline = $true)]
  [string[]]$TemplateFilePath,
  [Parameter(Mandatory = $True)]
  [string[]]$FilePath
)

BEGIN {
  $private:shouldEmitTemplates = $true
}

PROCESS {
  if ( $private:shouldEmitTemplates) {
    Write-Output $FilePath
    $private:shouldEmitTemplates = $false
  }

  Write-Output $TemplateFilePath
}

END { }