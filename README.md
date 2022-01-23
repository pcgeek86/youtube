### YouTube PowerShell Module

The purpose of this PowerShell module is to enable you to manage YouTube data from PowerShell.

### 🚀 Features

* Search for YouTube videos with queries
* Get details for YouTube videos (ie. duration, like count, comment count)

### 📦 Installation

We recommend installing this module on [PowerShell Core](https://github.com/powershell/powershell) edition, for cross-platform compatibility.
You can install this module from the [PowerShell Gallery](https://powershellgallery.com).

```
Install-Module -Name YouTube -Scope CurrentUser -Force
```

### 📄 Configuration

In order to use this module, you will need to configure an application in [Google Cloud Console](https://console.cloud.google.com).

* Create a Google Cloud Project
* Add the [YouTube Data API v3](https://console.cloud.google.com/marketplace/product/google/youtube.googleapis.com) to your project
* Go to `APIs & Services` --> `Credentials`
* Choose `Create Credentials` --> `oAuth Client ID`
* For `Application Type`, choose `TVs and Limited Input devices`
* Use the generated `Client ID` and `Client Secret` values to configure the module

After doing this, run the following command:

```
Set-YouTubeConfiguration
```

After configuring the client ID and client secret values, you will need to login to your YouTube account.

```
Grant-YouTube
```

### Usage

#### Search for YouTube videos.

```
PS /> Find-YouTubeVideo -Query 'trevor sullivan'

VideoId     Channel Title                   Published Date         Title
-------     -------------                   --------------         -----
LFWxH-bexNk Trevor Sullivan                 2/2/2020 9:49:30 PM    Handling Errors in PowerShell with Try..Catch..Finally
8dZbdl3wzW8 Trevor Sullivan                 12/12/2020 11:01:24 PM Run Tasks on Timers in PowerShell
jh361zZvOlg Trevor Sullivan                 1/21/2016 6:27:39 PM   Trevor Sullivan: Organ donation makes a difference (full clip)
4Ink31WKRmQ Midwest Management Summit       3/24/2016 2:20:03 AM   MMS 2016 Speaker Interview - Trevor Sullivan
-nGpXnjQVIQ Trevor Sullivan - NanangoCFC    1/16/2022 1:26:24 PM   2022.01.16 Isaiah 64 - The Heart&#39;s Cry of Believers in a Fallen World
8D23XL0b4zo Trevor Sullivan - NanangoCFC    1/22/2022 11:35:13 PM  2022.01.23 Isaiah 65 New Heavens &amp; New Earth
Y3_N9S6ZoEg Midwest Management Summit       10/13/2015 5:24:33 AM  MMS 2015 - Speaker Interview - Trevor Sullivan
bO264A6eoW0 Trevor Sullivan                 5/6/2019 3:11:15 AM    Original Choreography by Trevor Sullivan
-7uuXvQrvX8 Midwest Management Summit       10/25/2014 8:31:09 PM  MMS Speaker Interview - David O&#39;Brien and Trevor Sullivan
qwwnbXSm700 Trevor Sullivan                 11/12/2015 5:32:39 AM  Authoring Custom PowerShell Intellisense with Trevor Sullivan
D5W1HarSaZU Ignite Talks Burlington         2/26/2019 1:11:32 AM   Trevor Sullivan - Broccoli. Broccoli? BROCCOLI! - IgniteBTV 2/20/2019
tPs2ROyqrxI Trevor Sullivan                 1/20/2022 7:07:15 AM   Ya daddy
VqKD3JjA7Eo The QB School                   12/22/2021 2:00:11 PM  Free Trevor
qye_c4_pWQ4 CBT Nuggets                     1/18/2022 12:15:13 PM  What is InfluxDB and Why Use It?
```

#### Get Details for a YouTube Video

```
PS /> Get-YouTubeVideo -Id LFWxH-bexNk

VideoId     Channel Title   Views Likes Dislikes Comments Duration
-------     -------------   ----- ----- -------- -------- --------
LFWxH-bexNk Trevor Sullivan 6307  265   0        22       PT18M48S
```

#### Get Details for Multiple YouTube Videos

```
Get-YouTubeVideo -Id LFWxH-bexNk,8dZbdl3wzW8

VideoId     Channel Title   Views Likes Dislikes Comments Duration
-------     -------------   ----- ----- -------- -------- --------
LFWxH-bexNk Trevor Sullivan 6307  265   0        22       PT18M48S
8dZbdl3wzW8 Trevor Sullivan 4035  150   0        10       PT17M8S
```