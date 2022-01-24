Import-Module -Name $PSScriptRoot/../ -Force

$Subscriptions = Get-YouTubeSubscription

$Subscriptions.items[0].snippet.title
$Subscriptions.items[0].contentDetails

$AllResults = @()
$RawResult = Get-YouTubeSubscription -Raw
$AllResults += $RawResult
$RawResult = Get-YouTubeSubscription -Raw -NextPageToken $RawResult.nextPageToken
$AllResults += $RawResult
$RawResult = Get-YouTubeSubscription -Raw -NextPageToken $RawResult.nextPageToken
$AllResults += $RawResult
$RawResult = Get-YouTubeSubscription -Raw -NextPageToken $RawResult.nextPageToken
$AllResults += $RawResult

$AllResults.items