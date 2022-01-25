function New-YouTubeComment {
  <#
  .SYNOPSIS
  Creates a new top-level comment on a YouTube video.

  .EXAMPLE
  New-YouTubeComment -ChannelId UCGpJOTbsdZH_sBxihz6p_wg -VideoId LFWxH-bexNk -Text 'Hello from PowerShell! 👨🏻‍💻'
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
  Write-Verbose -Message $Uri
  $Headers = (Get-AccessToken) + @{
    'Content-Type' = 'application/json'
  }
  Write-Verbose -Message ($Headers | ConvertTo-Json)

  Invoke-RestMethod -Uri $Uri -Headers $Headers -Body $Body -Method Post
}