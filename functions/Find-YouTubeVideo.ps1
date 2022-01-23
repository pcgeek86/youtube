function Find-YouTubeVideo {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $Query,
    [string] $PageToken,
    [switch] $Raw
  )
  $Uri = 'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=50&q={0}' -f $Query
  if ($PageToken) {
    $Uri += '&pageToken={0}' -f $PageToken
  }

  $Result = Invoke-RestMethod -Uri $Uri -Headers (Get-AccessToken)
  
  if ($PSBoundParameters.ContainsKey('Raw')) { return $Result }

  $Result.Items | ForEach-Object -Process { $PSItem.PSTypeNames.Add('YouTube.VideoResult') }
  $Result.Items
}