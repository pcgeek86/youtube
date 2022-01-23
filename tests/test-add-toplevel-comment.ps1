Import-Module -Name $PSScriptRoot/../ -Force

$ChannelId = 'UCGpJOTbsdZH_sBxihz6p_wg'
$VideoId = 'LFWxH-bexNk'
$Text = 'This is a test comment from PowerShell'

New-YouTubeComment -ChannelId $ChannelId -VideoId $VideoId -Text $Text -Verbose