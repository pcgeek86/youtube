function Find-Browser {
  <#
  .SYNOPSIS
  Attempts to find a browser to use for Google oAuth.
  #>
  [CmdletBinding()]
  param (

  )

  $CommandList = @(
    'chrome.exe'
    'firefox.exe'
    'chrome'
    'firefox'
  )
  foreach ($Command in $CommandList) {
    if (Get-Command -Name $Command) { return $Command }
  }
}