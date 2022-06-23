# Youtube Downloader

Quick and dirty youtube video downloader using two different methods.

## Dependencies

-   Wordpress
-   composer
-   curl
-   FFMpeg
-   https://github.com/Athlon1600/youtube-downloader


## Installation

1.  Clone the repo.
2.  do a `composer install`
3.  install FFMpeg on your system if not already with:

```
sudo apt update
sudo apt install ffmpeg
ffmpeg -version
```


## Description

First, it does a quick youtube URL grab using the https://github.com/Athlon1600/youtube-downloader package. This returns the URLs for download.

You can then use one of two methods to actually download the videos.

1.  CURL. This will just download the entire video into the current wordpress uploads directory.
2.  FFMpeg. You can supply a start point and a duration to download a partial part of the video into the uploads directory.


## Shortcode

### [ytdl_curl]

The shortcode can take a `v=` parameter with the Video ID code from YouTube. So, the video https://www.youtube.com/watch?v=dQw4w9WgXcQ

will have a shortcode parameter value of `dQw4w9WgXcQ`

So to download that video, you can use:

```php
[ytdl_curl v="dQw4w9WgXcQ"]
```


The shortcode will also output a `var_dump()` of ALL the links to that video.

You'll find the full downloaded video in the uploads directory.


Alternatively, you can supply the shortcode with no parameters, but add the videoID on the page URL as a parameter that will pick it up as a `$_GET['v']` value.

```http
http://domain.com/mypage.php?v=dQw4w9WgXcQ
```

with:

```php
[ytdl_curl]
```

Will give the same result.



## Filters

### ytdl_curl

You can use the filter to run the `curl` version of the downloader.

```php
$args = ['dQw4w9WgXcQ'];
$result = apply_filters_ref_array('ytdl_curl', $args);
```


### ytdl_ffmpeg

This filter will use FFMpeg to download a partial part of the video.

```php
$args = [
  'dQw4w9WgXcQ', 	// videoID
  '00:00:00', 		// start point in the video
  '00:00:30'			// duration from start point
];
$result = apply_filters_ref_array('ytdl_ffmpeg', $args);
```

## NOTE

The FFMpeg process will run in a PHP `shell_exec()` command, so be careful with security and access to this, since it can run any command. All someone has to do is supply a semicolon and their own command to do anything.

