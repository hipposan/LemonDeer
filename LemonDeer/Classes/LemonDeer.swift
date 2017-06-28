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
  
  func update(_ progress: Float, with directoryName: String)
}

open class LemonDeer {
  public let downloader = VideoDownloader()
  public var progress: Float = 0.0
  public var directoryName: String = "" {
    didSet {
      m3u8Parser.identifier = directoryName
    }
  }
  public var m3u8URL = ""
  
  private let m3u8Parser = M3u8Parser()
  
  public weak var delegate: LemonDeerDelegate?
  
  public init() {
    
  }
  
  open func parse() {
    downloader.delegate = self
    m3u8Parser.delegate = self
    m3u8Parser.parse(with: m3u8URL)
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
  
  func update(_ progress: Float) {
    self.progress = progress
    
    delegate?.update(progress, with: directoryName)
  }
}
