function New-YouTubeComment {
  <#
  .SYNOPSIS
  Creates a new top-level comment on a YouTube video. (BROKEN: Logged ticket with YouTube: https://issuetracker.google.com/issues/215967256)
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $ChannelId,
    [Parameter(Mandatory = $true)]
    [string] $VideoId,
    [Parameter(Mandatory = $true)]
    [string] $Text
  )
  $Uri = 'https://www.googleapis.com/youtube/v3/commentThreads?part=snippet'

  $Body = @{
    snippet = @{
      videoId = $VideoId
      channelId = $ChannelId
      topLevelComment = @{
        snippet = @{
          textOriginal = $Text
        }
      }
    }
  } | ConvertTo-Json -Depth 5
  Write-Verbose -Message $Body
  Invoke-RestMethod -Uri $Uri -Headers (Get-AccessToken) -Body $Body -Method Post
}