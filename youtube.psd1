@{
  RootModule = 'youtube.psm1'
  Author = 'Trevor Sullivan <trevor@trevorsullivan.net>'
  CompanyName = 'Trevor Sullivan'
  ModuleVersion = '0.2'
  GUID = '4f1448cd-300f-444c-afdf-8ed678504ffd'
  Copyright = '2022 Trevor Sullivan'
  Description = 'Manage YouTube from the command line with PowerShell.'
  PowerShellVersion = '5.1'
  CompatiblePSEditions = @('Desktop', 'Core')
  FunctionsToExport = @(
    'Grant-YouTube'
    'Grant-YouTubeOauth'
    'Find-YouTubeVideo'
    'Find-YouTubeChannel'
    'Get-YouTubeVideo'
    'Set-YouTubeConfiguration'
    'Get-YouTubeCommentThread'
    'Get-YouTubeComment'
    'New-YouTubeComment'
    'Remove-YouTubeComment'
    'Get-YouTubeSubscription'
    'Remove-YouTubeSubscription'
    'Get-YouTubeActivity'
  )
  AliasesToExport = @('')
  VariablesToExport = @('')
  PrivateData = @{
    PSData = @{
      Tags = @('google', 'youtube')
      LicenseUri = ''
      ProjectUri = ''
      IconUri = ''
      ReleaseNotes = @'
0.1 - Initial realease
'@
    }
  }
  # HelpInfoURI = ''
}