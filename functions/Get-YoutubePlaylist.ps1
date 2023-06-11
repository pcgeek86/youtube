function Get-YouTubePlaylist {
    <#
    .SYNOPSIS
    Retrieves details for a YouTube channel.
  
    .PARAMETER ChannelId
    The array of channels that you want to get detailed information for.
    #>
    [CmdletBinding()]
    param (
      [Parameter(ParameterSetName = 'PlaylistId')]
      [string[]] $PlaylistId,
      [switch] $Raw
    )
    $Uri = 'https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails,id,snippet,status'
  
    switch ($PSCmdlet.ParameterSetName) {
      'PlaylistId' {
        $Uri += '&playlistId={0}' -f ($PlaylistId -join ',')
      }
    }
    Write-Verbose -Message $Uri
    $Result = Invoke-RestMethod -Uri $Uri -Method Get -Headers (Get-AccessToken)
    return $Result
  }