function Find-Browser {
  <#
  .SYNOPSIS
  Attempts to find a browser to use for Google oAuth.
  #>
  [CmdletBinding()]
  param (

  )
  
  if ($IsMacOS) {
    $ChromePath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    $FirefoxPath = "/Applications/Firefox.app/Contents/MacOS/firefox"

    if (Get-Item -Path $ChromePath) { return $ChromePath }
    if (Get-Item -Path $FirefoxPath) { return $FirefoxPath }

    throw 'Could not find browser on MacOS'
    return
  }

  $CommandList = @(
    'chrome.exe'
    'firefox.exe'
    'chrome'
    'firefox'
    'MicrosoftEdge.exe'
    'chromium',
    'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
  )
  foreach ($Command in $CommandList) {
    if ($BrowserCommand = Get-Command -Name $Command -ErrorAction Ignore) { return $BrowserCommand.source }
  }
  throw 'No web browser could be found to use for oAuth'
}
