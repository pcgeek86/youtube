function Set-YouTubeConfiguration {
  <#
  .SYNOPSIS
  Configures the YouTube module for PowerShell.
  #>
  [CmdletBinding()]
  param (
    [string] $ClientId,
    [string] $ClientSecret
  )
  
  if ($PSBoundParameters.Keys -notcontains 'ClientId') { $ClientId = Read-Host -Prompt 'Please enter YouTube client ID'}
  if ($PSBoundParameters.Keys -notcontains 'ClientSecret') { $ClientSecret = Read-Host -Prompt 'Please enter YouTube client secret'}

  @{
    client_id = $ClientId
    client_secret = $ClientSecret
  } | ConvertTo-Json | Set-Content -Path $ConfigPath
}