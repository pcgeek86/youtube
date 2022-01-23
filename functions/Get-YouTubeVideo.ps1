function Get-YouTubeVideo {
  <#
  .SYNOPSIS
  Retrieves details about a specific YouTube video, or multiple videos.

  .EXAMPLE
  Get-YouTubeVideo -Id LFWxH-bexNk

  .EXAMPLE
  Get-YouTubeVideo -Id LFWxH-bexNk,8dZbdl3wzW8
  #>
  [CmdletBinding()]
  param (
    [Parameter(ParameterSetName = 'VideoById')]
    [string[]] $Id,
    [Parameter(ParameterSetName = 'LikedVideos')]
    [switch] $Liked,
    [Parameter(ParameterSetName = 'DislikedVideos')]
    [switch] $Disliked,
    [switch] $Raw
  )

  $Parts = 'contentDetails,id,liveStreamingDetails,localizations,player,recordingDetails,snippet,statistics,status,topicDetails'
  $Uri = 'https://www.googleapis.com/youtube/v3/videos?part={0}&maxResults=50' -f $Parts
  
  if ($PSCmdlet.ParameterSetName -eq 'VideoById') { $Uri += '&id={0}' -f ($Id -join ',') }
  if ($PSCmdlet.ParameterSetName -eq 'LikedVideos') { $Uri += '&myRating=liked' }
  if ($PSCmdlet.ParameterSetName -eq 'DislikedVideos') { $Uri += '&myRating=disliked' }

  $Result = Invoke-RestMethod -Method Get -Uri $Uri -Headers (Get-AccessToken)

  if ($PSBoundParameters.ContainsKey('Raw')) { return $Result }

  $Result.items | ForEach-Object -Process { $PSItem.PSTypeNames.Add('YouTube.Video') }
  $Result.items
}