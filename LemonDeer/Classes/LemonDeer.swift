//
//  LemonDeer.swift
//  WindmillComic
//
//  Created by Ziyi Zhang on 09/06/2017.
//  Copyright © 2017 Ziyideas. All rights reserved.
//

import Foundation

public protocol LemonDeerDelegate: class {
  func videoDownloadSucceeded()
  func videoDownloadFailed()
  
  func updateProgressLabel(by percentage: String)
}

open class LemonDeer {
  public let downloader = VideoDownloader()
  let m3u8Parser = M3u8Parser()
  var playURL = ""
  var isM3u8 = false
  var progress = ""
  
  public weak var delegate: LemonDeerDelegate?
  
  public init(directoryName: String) {
    m3u8Parser.identifier = directoryName
  }
  
  open func parse(m3u8URL: String) {
    downloader.delegate = self
    m3u8Parser.delegate = self
    m3u8Parser.parse(with: m3u8URL)
    
    playURL = m3u8URL
  }
}

extension LemonDeer: M3u8ParserDelegate {
  func parseM3u8Succeeded(by parser: M3u8Parser) {
    downloader.tsPlaylist = parser.tsPlaylist
    downloader.m3u8Data = parser.m3u8Data
    downloader.startDownload()
  }
  
  func parseM3u8Failed(by parser: M3u8Parser) {
    print("Parse m3u8 file failed.")
  }
}

extension LemonDeer: VideoDownloaderDelegate {
  func videoDownloadSucceeded(by downloader: VideoDownloader) {
    delegate?.videoDownloadSucceeded()
  }
  
  func videoDownloadFailed(by downloader: VideoDownloader) {
    delegate?.videoDownloadFailed()
  }
  
  func updateProgressLabel(by percentage: String) {
    progress = percentage
    
    delegate?.updateProgressLabel(by: percentage)
  }
}
