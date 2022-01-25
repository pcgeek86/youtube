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
    [switch] $Raw
  )

  $Uri = 'https://www.googleapis.com/youtube/v3/commentThreads?part=id,replies,snippet'
  switch ($PSCmdlet.ParameterSetName) {
    'VideoId' {
      $Uri += '&videoId={0}' -f $VideoId
      break
    }
    'ChannelRelated' {
      $Uri += '&allThreadsRelatedToChannelId={0}' -f $RelatedToChannelId
      break
    }
  } 

  $Result = Invoke-RestMethod -Uri $Uri -Headers (Get-AccessToken)

  if ($PSBoundParameters.ContainsKey('Raw')) { return $Result }

  $Result.items | ForEach-Object -Process { $PSItem.PSTypeNames.Add('YouTube.CommentThread') }
  $Result.items
}