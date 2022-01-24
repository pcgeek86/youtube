function Remove-YouTubeSubscription {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $Id
  )
  $Uri = 'https://www.googleapis.com/youtube/v3/subscriptions?id={0}' -f $Id
  Invoke-RestMethod -Uri $Uri -Method Delete -Headers (Get-AccessToken)
}