function Get-YouTubeSubscription {
  [CmdletBinding()]
  param (
    [string] $NextPageToken,
    [switch] $Raw
  )

  $Uri = 'https://www.googleapis.com/youtube/v3/subscriptions?part=id,contentDetails,snippet,subscriberSnippet&mine=true&maxResults=50'
  if ($PSBoundParameters.ContainsKey('NextPageToken')) {
    $Uri += '&pageToken={0}' -f $NextPageToken
    Write-Verbose -Message 'Added next page token'
  }
  $Result = Invoke-RestMethod -Uri $Uri -Headers (Get-AccessToken)
  
  $Result.items | ForEach-Object -Process { $PSItem.PSTypeNames.Add('YouTube.Subscription') }
  
  if ($PSBoundParameters.ContainsKey('Raw')) { return $Result }

  $Result.items
}