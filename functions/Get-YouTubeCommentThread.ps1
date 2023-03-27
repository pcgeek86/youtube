function Get-YouTubeCommentThread {
  <#
  .SYNOPSIS
  Retrieves top-level comments from a video, or comments related to a channel.
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, ParameterSetName = 'VideoId')]
    [string] $VideoId,
    [Parameter(Mandatory = $true, ParameterSetName = 'ChannelRelated')]
    [string] $RelatedToChannelId,
    [switch] $Raw,
    [Parameter(Mandatory = $false, ParameterSetName = 'VideoId')]
    [Parameter(Mandatory = $false, ParameterSetName = 'ChannelRelated')]
    [int] $MaxResults = 100,
    [Parameter(Mandatory = $false, ParameterSetName = 'VideoId')]
    [Parameter(Mandatory = $false, ParameterSetName = 'ChannelRelated')]
    [string] $PageToken = ''
  )

  $Uri = 'https://www.googleapis.com/youtube/v3/commentThreads?part=id,replies,snippet'
  switch ($PSCmdlet.ParameterSetName) {
    'VideoId' {
      $Uri += '&videoId={0}&maxResults={1}' -f $VideoId, $MaxResults
      break
    }
    'ChannelRelated' {
      $Uri += '&allThreadsRelatedToChannelId={0}' -f $RelatedToChannelId
      break
    }
  }
  
  if ($PageToken) {
    $Uri += '&pageToken={0}' -f $PageToken
  }

  $Result = Invoke-RestMethod -Uri $Uri -Headers (Get-AccessToken)

  $Result.items | ForEach-Object -Process { $PSItem.PSTypeNames.Add('YouTube.CommentThread') }

  if ($PSBoundParameters.ContainsKey('Raw')) { return $Result }

  $Result.items
}
