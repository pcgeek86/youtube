function Get-YouTubeCommentThread {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, ParameterSetName = 'VideoId')]
    [string] $VideoId,
    [switch] $Raw
  )

  $Uri = 'https://www.googleapis.com/youtube/v3/commentThreads?part=id,replies,snippet'
  if ($PSCmdlet.ParameterSetName -eq 'VideoId') {
    $Uri += '&videoId={0}' -f $VideoId
  }

  $Result = Invoke-RestMethod -Uri $Uri -Headers (Get-AccessToken)

  if ($PSBoundParameters.ContainsKey('Raw')) { return $Result }

  $Result.items | ForEach-Object -Process { $PSItem.PSTypeNames.Add('YouTube.CommentThread') }
  $Result.items
}