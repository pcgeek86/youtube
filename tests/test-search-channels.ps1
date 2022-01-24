Import-Module -Name $PSScriptRoot/../ -Force

$Result = Find-YouTubeChannel -Query 'trevor sullivan'

#$Result | ConvertTo-Json -Depth 10 | Set-Content -Path ("$HOME/{0}.json" -f (New-Guid).Guid)

$Result.snippet