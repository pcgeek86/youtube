function Remove-YouTubeComment {
  <#
  .SYNOPSIS
  Deletes a YouTube comment.
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $Id
  )

  $Uri = 'https://www.googleapis.com/youtube/v3/comments?id={0}' -f $Id
  Invoke-RestMethod -Method Delete -Uri $Uri -Headers (Get-AccessToken)
}