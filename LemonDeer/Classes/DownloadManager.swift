//
//  DownloadManager.swift
//  Demo
//
//  Created by Ziyi Zhang on 14/06/2017.
//  Copyright © 2017 Ziyideas. All rights reserved.
//

import Foundation

protocol DownloadManagerDelegate {
  func downloadSucceeded(with downloadManager: DownloadManager)
  func downloadFailed(with downloadManager: DownloadManager)
}

public class DownloadManager: NSObject {
  var fileName: String = ""
  var filePath: String = ""
  
  
  
  var delegate: DownloadManagerDelegate?
  
  func generateFilePath() -> URL {
    return getDocumentsDirectory().appendingPathComponent("Downloads").appendingPathComponent(filePath).appendingPathComponent(fileName)
  }
}


