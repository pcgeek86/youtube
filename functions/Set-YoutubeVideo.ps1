function Set-YouTubeVideo {
    <#
    .SYNOPSIS
    Updates the tags for a YouTube video.
  
    .EXAMPLE
    Update-YouTubeVideoTags -VideoId LFWxH-bexNk -Tags 'PowerShell', 'YouTube API'
    #>
    [CmdletBinding()]
    param (
      [Parameter(Mandatory = $true)]
      [string] $VideoId,
      [Parameter(Mandatory = $true)]
      [string[]] $Tags
    )
    $Uri = "https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$VideoId"
  
    $Body = @{
      id = $VideoId
      snippet = @{
        tags = $Tags
        title = "pineapple"
        categoryId = "22"
      }
    } | ConvertTo-Json -Depth 5
  
    $Headers = (Get-AccessToken) + @{
      'Content-Type' = 'application/json'
    }
  
    Invoke-RestMethod -Uri $Uri -Headers $Headers -Body $Body -Method Put
  }