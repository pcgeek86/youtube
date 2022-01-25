function Add-YouTubeSubscription {
  <#
  .SYNOPSIS
  Subscribe to a YouTube channel, with the specified ChannelId.

  .PARAMETER ChannelId
  The YouTube channel ID that you want to subscribe to.
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $ChannelId
  )
  $Uri = 'https://www.googleapis.com/youtube/v3/subscriptions?part=contentDetails,id,snippet,subscriberSnippet'
  $Headers = (Get-AccessToken) + @{
    'Content-Type' = 'application/json'
  }
  $Body = @{
    snippet = @{
      resourceId = @{
        channelId = $ChannelId
      }
    }
  } | ConvertTo-Json -Depth 5
  Write-Verbose -Message $Uri
  Write-Verbose -Message $Body
  Write-Verbose -Message ($Headers | ConvertTo-Json)
  Invoke-RestMethod -Uri $Uri -Method Post -Headers $Headers -Body $Body
}