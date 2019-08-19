[CmdletBinding()]
param
(
  [Parameter(Mandatory = $True, ValueFromPipeline = $true)]
  [string[]]$TemplateName,
  [string]$OutPath = (Get-Location)
)

BEGIN {
  Set-Variable -Name GITHUB_IGNORE_ROOT_URI         -Value ([System.Uri]::new("https://raw.githubusercontent.com/github/gitignore/master/")) -Option Constant
  Set-Variable -Name GITHUB_IGNORE_ROOT_GLOBAL_URI  -Value ([System.Uri]::new($GITHUB_IGNORE_ROOT_URI, "Global/")) -Option Constant
  $private:githubUriList = $GITHUB_IGNORE_ROOT_URI, $GITHUB_IGNORE_ROOT_GLOBAL_URI

  Set-Variable -Name OUT_DIRECTORY -Value ($OutPath) -Option Constant
}

PROCESS {
  try {
    foreach ( $private:name in $TemplateName) {
      $private:templateFound = $false
      foreach ($private:rootUri in $private:githubUriList) {
        $private:uri = ([System.Uri]::new($private:rootUri, $private:name)).ToString()
        try {
          $private:requestResult = Invoke-WebRequest -Uri $private:uri -Method Head 
          if ( 200 -eq $private:requestResult.StatusCode ) {
            $private:filePath = Join-Path -Path $OUT_DIRECTORY -ChildPath $private:name
            Invoke-WebRequest -Uri $private:uri -Method Get -OutFile $private:filePath
            Write-Output $private:filePath
            $private:templateFound = $true
          }
        }
        catch { } 
      }
      if ( !$private:templateFound) {
        throw "The git .gitignore template '$private:name' was not found."
      }
    }
  }
  finally { }
}

END { }