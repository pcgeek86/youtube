function Grant-Youtube {
  <#
  .SYNOPSIS
  Implementation of device (ie. Android TV) authentication for YouTube APIs.
  #>
  [CmdletBinding()]
  param (
  )

  $Client = Get-Content -Path $ConfigPath | ConvertFrom-Json
  Write-Verbose -Message $Client
  $GrantType = 'urn:ietf:params:oauth:grant-type:device_code'
  $Uri = 'https://oauth2.googleapis.com/device/code?client_id={0}&scope={1}' -f $Client.client_id, $Scopes
  $Response = Invoke-RestMethod -Method Post -Uri $Uri
  Write-Host -Object ('Open your browser and go to https://www.google.com/device, enter code {0}' -f $Response.user_code)

  while ((Get-Date) -lt (Get-Date).AddSeconds($Response.expires_in)) {
    $ValidateUri = 'https://oauth2.googleapis.com/token?client_id={0}&grant_type={1}&client_secret={2}&device_code={3}' -f $Client.client_id, $GrantType, $Client.client_secret, $Response.device_code
    Write-Host -Object $ValidateUri
    try {
      Invoke-RestMethod -Method Post -Uri $ValidateUri -ErrorVariable validateerror | ConvertTo-Json | Set-Content -Path $HOME/.pwsh.youtube.json
    }
    catch {
      if ($ValidateError) { Write-Host -Object 'Waiting for authorization ...' }
    }
    if (!$ValidateError) { Write-Host 'Authorization success' -ForegroundColor green; break }
    Start-Sleep -Seconds 10
  }
}