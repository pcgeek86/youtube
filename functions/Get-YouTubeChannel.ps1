function Get-YouTubeChannel {
  <#
  .SYNOPSIS
  Retrieves details for a YouTube channel.

  .PARAMETER ChannelId
  The array of channels that you want to get detailed information for.
  #>
  [CmdletBinding()]
  param (
    [Parameter(ParameterSetName = 'ChannelId')]
    [string[]] $Id,
    [switch] $Raw
  )
  $Uri = 'https://www.googleapis.com/youtube/v3/channels?part=brandingSettings,contentDetails,contentOwnerDetails,id,snippet,localizations,statistics,status,topicDetails'

  switch ($PSCmdlet.ParameterSetName) {
    'ChannelId' {
      $Uri += '&id={0}' -f ($Id -join ',')
    }
  }
  Write-Verbose -Message $Uri
  $Result = Invoke-RestMethod -Uri $Uri -Method Get -Headers (Get-AccessToken)
  $Result.items | ForEach-Object -Process { $PSItem.PSTypeNames.Add('YouTube.Channel') }

  if ($Raw) { return $Result }
  $Result.items
}
