Import-Module -Name $PSScriptRoot/../ -Force

$Activities = Get-YouTubeActivity -Mine

$Activities

Get-YouTubeActivity -ChannelId UCGpJOTbsdZH_sBxihz6p_wg