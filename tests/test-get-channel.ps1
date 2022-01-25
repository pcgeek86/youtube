Import-Module -Name $PSScriptRoot/.. -Force
return
$ChannelList = Find-YouTubeChannel -Query bacon

$Details = Get-YouTubeChannel -Id $ChannelList.id.channelId -Verbose

$Details

