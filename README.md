### YouTube PowerShell Module

The purpose of this PowerShell module is to enable you to manage YouTube data from PowerShell.

### 🚀 Features

* Search for YouTube videos or channels
* Get details for YouTube videos (ie. duration, like count, comment count)
* Retrieve top-level comments from YouTube videos
* Delete a comment, from a YouTube video you own
* [Post a comment](#-🗨️-post-comment-on-youtube-video) on a video
* Subscribe or unsubscribe from a YouTube channel

### 📦 Installation

We recommend installing this module on [PowerShell Core](https://github.com/powershell/powershell) edition, for cross-platform compatibility.
You can install this module from the [PowerShell Gallery](https://powershellgallery.com).

```
Install-Module -Name YouTube, Pode -Scope CurrentUser -Force
```

This YouTube module relies on the [Pode web server]() to handle the oAuth flow.
A temporary web server will be created in order to 

### 📄 Configuration

In order to use this module, you will need to configure an application in [Google Cloud Console](https://console.cloud.google.com).

#### Standard oAuth Flow

* Create a Google Cloud Project
* Add the [YouTube Data API v3](https://console.cloud.google.com/marketplace/product/google/youtube.googleapis.com) to your project
* Go to `APIs & Services` --> `Credentials`
* Choose `Create Credentials` --> `oAuth Client ID`
* For `Application Type`, choose `Web Application`
* Use the generated `Client ID` and `Client Secret` values to configure the module

After doing this, run the following command:

```
Set-YouTubeConfiguration
```

After configuring the client ID and client secret values, you will need to login to your YouTube account.

```
Grant-YouTubeOAuth
```

#### Smart TV Auth Flow

* Follow the steps above to create an application
* For `Application Type`, choose `TVs and Limited Input devices` instead
* Run the `Grant-YouTube` command to initiate authentication

⚠️ It's important to note that this login method has reduced access to APIs, so generally you'll want to use the standard oAuth flow for server-side web applications.

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
PS /> Get-YouTubeVideo -Id LFWxH-bexNk,8dZbdl3wzW8

VideoId     Channel Title   Views Likes Dislikes Comments Duration
-------     -------------   ----- ----- -------- -------- --------
LFWxH-bexNk Trevor Sullivan 6307  265   0        22       PT18M48S
8dZbdl3wzW8 Trevor Sullivan 4035  150   0        10       PT17M8S
```

#### Get Comments for a Video

```
PS /> Get-YouTubeComment -VideoId LFWxH-bexNk

Get-YouTubeCommentThread -VideoId LFWxH-bexNk

CommentId                  PublishedAt            Updated At             Replies Like Count Commenter       Text
---------                  -----------            ----------             ------- ---------- ---------       ----
UgwJX6qbSv6qyfKiXFB4AaABAg 11/7/2021 1:33:41 PM   11/7/2021 1:33:41 PM   0       0          BRANESH G       Fantastic! Thanks a lot for the perfect explanation. 👍
Ugwj7UBjIIJPNQ1kxbx4AaABAg 10/28/2021 11:45:30 AM 10/28/2021 11:45:30 AM 0       0          닉네임          잘 보고 있습니다. 눈이 이쁘시네요.
UgwjrWy5th_EO7FDxwx4AaABAg 9/9/2021 8:06:25 PM    9/9/2021 8:06:25 PM    0       0          Ausaf Ahmed     Hi Trevor<br><br>Please share your secret how you learn about all these details just going through microsoft documentation in deta… 
UgzTzb__OsBJ0cCkaEx4AaABAg 9/8/2021 5:59:42 PM    9/8/2021 5:59:42 PM    0       0          Surfer Sandman  This was fantastic. Thanks so much for this detailed explanation. I&#39;ve been using Try/Catch statements, for a while, but was o… 
UgykzIT-NBxGW9nlZ194AaABAg 7/20/2021 4:16:20 AM   7/20/2021 4:16:20 AM   0       0          GameHistoryX    Awesome!
UgyVBWwjcnBA1CSfdUN4AaABAg 5/18/2021 2:16:12 AM   5/18/2021 2:16:12 AM   0       0          Steven ls       Amazing, so well explained.  I do like the ErrorActionPreference also, didn&#39;t understand that previously.  Glad to have found … 
UgzELqIF1tKP2twr4-14AaABAg 3/22/2021 10:42:12 AM  3/22/2021 10:42:12 AM  0       0          M. SZ.          Thanks!
UgxMpQcFrD-nA2yjpCl4AaABAg 2/13/2021 6:36:00 PM   2/13/2021 6:36:00 PM   0       0          Po prostu kanał it&#39;s maybe a bit lame, but could you explain in another video how you move around the lines, select whole sentence in quote or… 
UgxmX75pC_XlOGOtGqJ4AaABAg 1/24/2021 11:14:35 PM  1/24/2021 11:14:35 PM  2       0          C U             What is all this about write-host kills puppies? I use it in all of my try catch blocks and it produces fine for me. I also cannot… 
Ugy2U7gW_ZUvVprPlAt4AaABAg 1/7/2021 9:04:17 PM    1/7/2021 9:04:17 PM    0       0          HaasiAustria    Hello! Do you know, is &quot;finally&quot; removed? I get the error: &quot;the term finally is not recognized as the name of a cmd… 
UgwaFspdil_xTmU7wzR4AaABAg 6/28/2020 2:17:16 PM   6/28/2020 2:17:16 PM   0       1          Vaska Tito      Thx a lot man! I&#39;m a beginner and i was starting to loose my temper because my catch was not working... i just had to add the … 
UgzlKKVpGjUdgUrLbER4AaABAg 6/12/2020 9:30:13 AM   6/12/2020 9:30:13 AM   0       0          Ben Mathew      Excellent video,flow throughout the video is good
UgzwjM_BfwhEeDdYxMp4AaABAg 2/15/2020 4:59:16 AM   2/15/2020 4:59:16 AM   0       0          Matthew Bramer  Very good content! Was hoping you&#39;d cover $LASTEXITCODE and when that comes into play. Maybe a follow up is in order. 😊        
Ugy2qdM7_KMJ_zvZTKF4AaABAg 2/9/2020 10:35:14 AM   2/9/2020 10:35:14 AM   0       1          tutu            Excellent! As usual, your teaching talents are exceptional! Thank you so much for sharing your videos with us!
UgwWPyE_qmAnzPBWf5t4AaABAg 2/8/2020 2:38:45 PM    2/8/2020 2:38:45 PM    0       0          Ay Jay          Under normal circumstances, how does PowerShell know when a given exception is terminating or not?
UgyURVdTOxDbbNi6JfJ4AaABAg 2/6/2020 5:20:42 AM    2/6/2020 5:20:42 AM    0       1          Dylan Robey     Very good video. Wish I had found you when I was a Powershell noob!
UgwMHBsGm_sL3cMMzA14AaABAg 2/3/2020 8:35:19 PM    2/3/2020 8:35:19 PM    0       1          Semtx552        Always nice to see handy things like how someone else uses VSCode…
UgwTUdL6EeyOSc-6-8p4AaABAg 2/2/2020 11:46:46 PM   2/2/2020 11:46:46 PM   1       2          Guido Oliveira  This camera quality is amazing Trevor! awesome explanation as well!
UgxWz7fai70eXgLKLwV4AaABAg 2/2/2020 10:05:14 PM   2/2/2020 10:05:14 PM   0       1          Josh King       That pop filter is majestic!
```

#### 🗨️ Remove a YouTube Comment

```
Remove-YouTubeComment -Id <commentId>
```

#### 🗨️ Post Comment on YouTube Video 

```
New-YouTubeComment -ChannelId <channelId> -VideoId <videoId> -Text 'This is a great video! 📺'
```

