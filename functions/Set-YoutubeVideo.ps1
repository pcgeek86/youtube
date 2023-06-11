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
      [Parameter(Mandatory = $false)]
      [string[]] $Tags,
      [Parameter(Mandatory = $false)]
      [string] $Title,
      [Parameter(Mandatory = $false)]
      [string] $categoryId,
      [Parameter(Mandatory = $false)]
      [string] $Description,
      [ValidateSet('unlisted','private','public')] 
      [Parameter(Mandatory=$False)]
      [string]$PrivacyStatus,
      [Parameter(Mandatory=$False)]
      [string]$selfDeclaredMadeForKids,
      [Parameter(Mandatory=$False)]
      [string]$publishAt
    )

    Write-Verbose "Getting video from API"
    $currentVideo = Get-YouTubeVideo -Id $VideoId -Raw
    Write-Verbose ($currentVideo | ConvertTo-Json)
    $Uri = "https://www.googleapis.com/youtube/v3/videos?part=snippet,status&id=$VideoId"
  
    $Body = @{
      id = $VideoId
      snippet = @{
      }
      status = @{
      }
    }

    if (![string]::IsNullOrEmpty($Title)) {
      #update title
      $Body.snippet.title = $Title
    }else{
      #use existing title
      $Body.snippet.title = $currentVideo.items.snippet.title
    }

    if (![string]::IsNullOrEmpty($categoryId)) {
      #update category
      $Body.snippet.categoryId = $categoryId
    }else{
      #use existing category
      $Body.snippet.categoryId = $currentVideo.items.snippet.categoryId
    }

    if (![string]::IsNullOrEmpty($Tags)) {
      $Body.snippet.tags = $Tags
    }

    if (![string]::IsNullOrEmpty($Description)) {
      $Body.snippet.description = $Description
    }

    if (![string]::IsNullOrEmpty($PrivacyStatus)) {
      $Body.status.privacyStatus = $PrivacyStatus
    }else{
      $Body.status.privacyStatus = $currentVideo.items.status.privacyStatus
    }

    if (![string]::IsNullOrEmpty($selfDeclaredMadeForKids)) {
      $Body.status.selfDeclaredMadeForKids = [bool]$selfDeclaredMadeForKids
    }else{
      $Body.status.selfDeclaredMadeForKids = [bool]$currentVideo.items.status.selfDeclaredMadeForKids
    }

    if (![string]::IsNullOrEmpty($publishAt)) {
      $Body.status.publishAt = (Get-Date).AddDays(2).ToString("yyyy-MM-ddTHH:mm:ssZ")
      #https://developers.google.com/youtube/v3/docs/videos/update?hl=de
      #status.publishAt: Wenn Sie einen Wert für dieses Attribut festgelegt haben, müssen Sie auch das Attribut status.privacyStatus auf private setzen.
      $Body.status.privacyStatus = 'private'
    }
    
    $BodyJSON = $Body | ConvertTo-Json -Depth 10
  
    $Headers = (Get-AccessToken) + @{
      'Content-Type' = 'application/json'
    }
  
    Invoke-RestMethod -Uri $Uri -Headers $Headers -Body $BodyJSON -Method Put
  }

  