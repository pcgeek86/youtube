# Clean up old Chromium processes
gps chrome | ? { $PSItem.MainModule.Filename -match 'chromium' } | spps

Import-Module -Name $PSScriptRoot/../ -Force

Get-Module -Name YouTube

Grant-Youtube