function Grant-YoutubeOauth {
  <#
  .SYNOPSIS
  Implementation of oAuth authentication for YouTube APIs.

  .PARAMETER BrowserCommand
  Use this parameter to override the command line to launch your browser (ie. chrome.exe, firefox, firefox.exe, chromium, etc.)
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $false)]
    [string] $BrowserCommand
  )

  $JobName = 'youtubetempwebserver'
  Start-Job -Name $JobName -ScriptBlock {
    Start-PodeServer -ScriptBlock {
      Add-PodeEndpoint -Port 8000 -Protocol Http
      Add-PodeRoute -Method Get -Path /auth/complete -ScriptBlock {
        @{
          access_token = $WebEvent.Query['access_token']
          refresh_token = $WebEvent.Query['refresh_token']
        } | ConvertTo-Json | Set-Content -Path $HOME/.pwsh.youtube.oauth.json

        $Response = @'
        <h1 style="font-family: sans-serif;">Authentication Complete</h1>
        <h3 style="font-family: sans-serif;">You may close this browser window.</h3>
        <script>
          console.log(window.location.hash);
          let access_token_regex = /access_token=(?<access_token>.*?)&token_type/;
          let access_token_result = access_token_regex.exec(window.location.hash);

          let refresh_token_regex = /refresh_token=(?<refresh_token>.*?)&/;
          let refresh_token_result = refresh_token_regex.exec(window.location.hash);
          fetch(`/auth/complete?access_token=${access_token_result.groups.access_token}&refresh_token=${refresh_token_result.groups.refresh_token}`);
        </script>
'@
        Write-PodeHtmlResponse -Value $Response
      }
    }
  }

  $Client = Get-Content -Path $ConfigPath | ConvertFrom-Json
  $RedirectUri = 'http://localhost:8000/auth/complete'
  $ScopeList = @(
    'https://www.googleapis.com/auth/youtube'
    'https://www.googleapis.com/auth/youtube.force-ssl'
    'https://www.googleapis.com/auth/youtube.readonly'
  )
  $Uri = 'https://accounts.google.com/o/oauth2/v2/auth?include_granted_scopes=true&access_type=offline&response_type=token&client_id={0}&redirect_uri={1}&scope={3}&state={2}' -f $Client.client_id, $RedirectUri, (New-Guid).Guid, ($ScopeList -join ' ')

  $Browser = $BrowserCommand ? $BrowserCommand : (Find-Browser)
  Write-Verbose -Message ('Browser command line is: ' -f $Browser)
  Start-Process -FilePath $Browser -ArgumentList ('"{0}"' -f $Uri) -Wait

  if (!$IsMacOS) {
    Stop-Job -Name $JobName
  }
  else {
    Write-Warning -Message 'Please manually stop the Background Job running the Pode web server after completing authentication. Cannot wait for browser process to complete on MacOS.'
  }
}
