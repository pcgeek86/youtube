function Set-YouTubeVideoRating {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $VideoId,
    [Parameter(Mandatory = $false)]
    [ValidateSet('dislike','like','none')]
    [string] $Rating = 'none'
  )

  $Request = @{
    Uri = 'https://www.googleapis.com/youtube/v3/videos/rate?id={0}&rating={1}' -f $VideoId, $Rating
    Method = 'Post'
    Headers = (Get-AccessToken)
  }
  Invoke-RestMethod @Request
}