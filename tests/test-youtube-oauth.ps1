# Clean up old Chromium processes
Get-Process chrome | Where-Object -FilterScript { $PSItem.MainModule.Filename -match 'chromium' } | Stop-Process

Import-Module -Name $PSScriptRoot/../ -Force

Grant-YouTubeOauth