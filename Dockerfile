FROM mcr.microsoft.com/powershell

SHELL [ "pwsh", "-Command" ]

ADD [".", "/youtube"]

RUN $env:PSModulePath += ':/'; \
  mkdir --parents $HOME/.config/powershell ; \
  Set-Content -Path $PROFILE.CurrentUserAllHosts -Value 'Import-Module -Name /youtube; Set-YouTubeConfiguration'

ENTRYPOINT [ "pwsh" ]