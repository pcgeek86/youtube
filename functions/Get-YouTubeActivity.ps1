function Get-YouTubeActivity {
  <#
  .SYNOPSIS
  Obtain activities performed by yourself or a specific channel ID.
  #>
  [CmdletBinding()]
  param (
    [Parameter(ParameterSetName = 'ChannelId')]
    [string] $ChannelId,
    [Parameter(ParameterSetName = 'Mine')]
    [switch] $Mine,
    [Parameter(ParameterSetName = 'ChannelId')]
    [Parameter(ParameterSetName = 'Mine')]
    [switch] $Raw
  )
  
  $Uri = 'https://www.googleapis.com/youtube/v3/activities?part=id,snippet,contentDetails&maxResults=50'

  switch ($PSCmdlet.ParameterSetName) {
    'Mine' {
      $Uri += '&mine=true'
      break
    }
    'ChannelId' {
      $Uri += '&channelId={0}' -f $ChannelId
    }
  }
  $Result = Invoke-RestMethod -Uri $Uri -Headers (Get-AccessToken)

  $Result.items | ForEach-Object -Process { $PSItem.PSTypeNames.Add('YouTube.Activity') }

  if ($PSBoundParameters.ContainsKey('Raw')) { $Result }

  $Result.items
}