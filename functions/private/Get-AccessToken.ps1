function Get-AccessToken {
  [CmdletBinding()]
  param (
    [switch] $DeviceToken
  )
  $ErrorActionPreference = 'stop'
  try {
    if (!$PSBoundParameters['DeviceToken']) {
      # Return OAuth token obtained via web flow (preferred)
      Write-Verbose -Message 'Returning oAuth token from web-based authentication flow'
      return @{
        Authorization = 'Bearer {0}' -f (Get-Content -Path $HOME/.pwsh.youtube.oauth.json | ConvertFrom-Json | Select-Object -ExpandProperty access_token)
      }
    }
    else {
      # Return access token from device authentication flow
      return @{
        Authorization = 'Bearer {0}' -f (Get-Content -Path $HOME/.pwsh.youtube.json | ConvertFrom-Json | Select-Object -ExpandProperty access_token)
      }
    }
  }
  catch {
    throw 'Please use Set-YouTubeConfiguration to authorize the YouTube module for PowerShell.'
  }
}