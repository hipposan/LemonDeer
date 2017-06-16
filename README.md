<p align="center">
  <img src="https://raw.githubusercontent.com/hipposan/LemonDeer/master/Resources/LemonDeer-logo.png" width=600 />
  <p align="center"><i>Make m3u8 parse and download as white magic.</i></p>
</p>

<p align="center">
  <a href="https://travis-ci.org/hipposan/LemonDeer">
    <img src="http://img.shields.io/travis/hipposan/LemonDeer.svg?style=flat" alt="Build Status">
  </a>
  <a href="http://cocoapods.org/pods/LemonDeer">
    <img src="https://img.shields.io/cocoapods/v/LemonDeer.svg?style=flat?colorB=7761c8" alt="Pods Version">
  </a>
  <a href="http://cocoapods.org/pods/LemonDeer">
    <img src="https://img.shields.io/cocoapods/p/LemonDeer.svg?style=flat?colorB=cf649a" alt="Platforms">
  </a>
  <a href="https://swift.org/">
    <img src="https://img.shields.io/badge/Swift-3.1-orange.svg" alt="Swift Version">
  </a>
  <a href="https://raw.githubusercontent.com/hipposan/LemonDeer/master/LICENSE">
    <img src="https://img.shields.io/github/license/mashape/apistatus.svg?colorB=dfca6c" alt="License">
  </a>
   <a href="https://twitter.com/zzy0600">
    <img src="https://img.shields.io/badge/Twitter-%40zzy0600-blue.svg" alt="Twitter">
  </a>
</p>

___________________

Features|
------------------------------- |
Parse and download m3u8 files|
Customize downloading progress|
Pure Swift|
Comprehensive Documents|


## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements
* Xcode 8.0+
* iOS 9.0+
* Swift 3.0+

> **Note:**
> * Your m3u8 file should include **#EXFINT** information to make parsing pass.
> * Your local server's port should be **8080** to make local video play.


## Usage
Define dowloading directory name:

```swift
let directoryName = "Name"
let lemonDeer = LemonDeer(directoryName: directoryName)
```
____________

Parse and begin downloading m3u8 with URL:

```swift
let lemonDeer = LemonDeer(directoryName: "Demo")
let url = "https://urlstring.m3u8"
lemonDeer.parse(m3u8URL: url)
```
____________

Manipulate downloading process:
* Pause

```swift
lemonDeer.downloader.pauseDownloadSegment()
```

* Resume

```swift
lemonDeer.downloader.resumeDownloadSegment()
```

* Cancel

```swift
lemonDeer.downloader.cancelDownloadSegment()
```
____________

Delete downloaded contents
* Delete a specific directory

```swift
lemonDeer.downloader.deleteDownloadedContents(with: ("DirectoryNameYouWantToDelete")
```

* Delete all downloaded contents

```swift
lemonDeer.downloader.deleteAllDownloadedContents()
```
____________

Define your own after download succeeded

```swift
class YourClass: LemonDeerDelegate {
  func videoDownloadSucceeded()
}
```

Define your own after download failed

```swift
class YourClass: LemonDeerDelegate {
  func videoDownloadFailed()
}
```

Customize downloading progress

```swift
class YourClass: LemonDeerDelegate {
  func updateProgressLabel(by percentage: String)
}
```

## Installation
LemonDeer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LemonDeer"
```

## Author
Contact me at [Twitter](https://twitter.com/zzy0600).


## License
LemonDeer is available under the MIT license. See the LICENSE file for more info.
