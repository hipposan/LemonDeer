//
//  SegmentDownloader.swift
//  WindmillComic
//
//  Created by Ziyi Zhang on 09/06/2017.
//  Copyright © 2017 Ziyideas. All rights reserved.
//

import Foundation

protocol SegmentDownloaderDelegate {
  func segmentDownloadSucceeded(with downloader: SegmentDownloader)
  func segmentDownloadFailed(with downloader: SegmentDownloader)
}

class SegmentDownloader: NSObject {
  var fileName: String
  var filePath: String
  var downloadURL: String
  var duration: Float
  var index: Int
  
  lazy var downloadSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    
    return session
  }()
  
  var downloadTask: URLSessionDownloadTask?
  var resumeData: Data?
  var isDownloading = false
  
  var delegate: SegmentDownloaderDelegate?
  
  init(with url: String, filePath: String, fileName: String, duration: Float, index: Int) {
    downloadURL = url
    self.filePath = filePath
    self.fileName = fileName
    self.duration = duration
    self.index = index
  }
  
  func startDownload() {
    if checkIfIsDownloaded() {
      delegate?.segmentDownloadSucceeded(with: self)
      return
    } else {
      downloadTask = downloadSession.downloadTask(with: URL(string: downloadURL)!)
      downloadTask?.resume()
      isDownloading = true
    }
  }
  
  func cancelDownload() {
    downloadTask?.cancel()
    isDownloading = false
  }
  
  func pauseDownload() {
    if isDownloading {
      downloadTask?.suspend()
      
      isDownloading = false
    }
  }
  
  func resumeDownload() {
    downloadTask?.resume()
    isDownloading = true
  }
  
  func checkIfIsDownloaded() -> Bool {
    let filePath = generateFilePath().path
    
    if FileManager.default.fileExists(atPath: filePath) {
      return true
    } else {
      return false
    }
  }
  
  func generateFilePath() -> URL {
    return getDocumentsDirectory().appendingPathComponent("Downloads").appendingPathComponent(filePath).appendingPathComponent(fileName)
  }
}

extension SegmentDownloader: URLSessionDownloadDelegate {
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    let destinationURL = generateFilePath()
    
    if FileManager.default.fileExists(atPath: destinationURL.path) {
      delegate?.segmentDownloadSucceeded(with: self)
      return
    } else {
      do {
        try FileManager.default.moveItem(at: location, to: destinationURL)
        delegate?.segmentDownloadSucceeded(with: self)
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    }
  }
  
  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    if error != nil {
      delegate?.segmentDownloadFailed(with: self)
    }
  }
  
}
