
$script:RedirectUri = 'http://localhost:8000/auth/complete'
$script:Scopes = 'https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.readonly'
$script:ConfigPath = "$HOME/.pwsh.youtube.config.json"

$FileList = Get-ChildItem -Path $PSScriptRoot/functions/*ps1

foreach ($File in $FileList) {
  . $File.FullName
}

$FileList = Get-ChildItem -Path $PSScriptRoot/functions/private/*ps1

foreach ($File in $FileList) {
  . $File.FullName
}

$FormatList = Get-ChildItem -Path $PSScriptRoot/formats/*ps1xml
foreach ($Format in $FormatList) {
  Update-FormatData -PrependPath $Format.FullName
}