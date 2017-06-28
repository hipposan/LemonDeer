//
//  ViewController.swift
//  Demo
//
//  Created by Ziyi Zhang on 23/06/2017.
//  Copyright © 2017 hippo_san. All rights reserved.
//

import UIKit
import AVFoundation

import LemonDeer
import GCDWebServer

class ViewController: UIViewController {
  @IBOutlet var progressLabel: UILabel!
  @IBOutlet var downloadButton: UIButton!
  @IBOutlet var playerView: UIView!
  
  fileprivate var isDownloading = false
  fileprivate var duringDownloadingProcess = false
  
  private let lemonDeer = LemonDeer(directoryName: "Demo")
  private var server: GCDWebServer! = nil
  private var player = AVPlayer()
  private var playerLayer = AVPlayerLayer()
  
  @IBAction func download(_ sender: Any) {
    if !isDownloading {
      DispatchQueue.main.async {
        self.downloadButton.setTitle("Pause", for: .normal)
      }
      
      isDownloading = true
      
      if duringDownloadingProcess {
        lemonDeer.downloader.resumeDownloadSegment()
      } else {
        let url = "http://pl-ali.youku.com/playlist/m3u8?ts=1497413452&keyframe=1&vid=704675076&type=hd2&sid=0497413452394200e1f61&token=8269&oip=1696929637&did=2739b348d6020958407ddebff48b76bd&ctype=20&ev=1&ep=yZa8BLwhkewm%2BJYwNpWin%2BP9q1Xl%2FcCHzQ80y23Oig6QzYfmciUxpx%2F65Yk1CRBd"
        
        lemonDeer.delegate = self
        lemonDeer.parse(m3u8URL: url)
      }
    } else {
      DispatchQueue.main.async {
        self.downloadButton.setTitle("Download", for: .normal)
      }
      
      isDownloading = false
      duringDownloadingProcess = true
      
      lemonDeer.downloader.pauseDownloadSegment()
    }
  }
  @IBAction func playOnlineVideo(_ sender: Any) {
    configurePlayer(with: "http://pl-ali.youku.com/playlist/m3u8?ts=1497413452&keyframe=1&vid=704675076&type=hd2&sid=0497413452394200e1f61&token=8269&oip=1696929637&did=2739b348d6020958407ddebff48b76bd&ctype=20&ev=1&ep=yZa8BLwhkewm%2BJYwNpWin%2BP9q1Xl%2FcCHzQ80y23Oig6QzYfmciUxpx%2F65Yk1CRBd")
  }
  
  @IBAction func playLocalVideo(_ sender: Any) {
    server = GCDWebDAVServer(uploadDirectory: getDocumentsDirectory().appendingPathComponent("Downloads").appendingPathComponent("Demo").path)
    server.start()
    
    configurePlayer(with: "http://127.0.0.1:8080/Demo.m3u8")
  }
  
  @IBAction func deleteDownloadedContents(_ sender: Any) {
    lemonDeer.downloader.deleteAllDownloadedContents()
    
    progressLabel.text = "0 %"
  }
  
  @IBAction func deleteContentWithName(_ sender: Any) {
    let alert = UIAlertController(title: "Delete Content", message: "Input the name of directory you want to delete.", preferredStyle: .alert)
    alert.addTextField()
    
    let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alert] _ in
      self.lemonDeer.downloader.deleteDownloadedContents(with: (alert?.textFields?[0].text)!)
      
      self.progressLabel.text = " "
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [weak alert] _ in
      alert?.dismiss(animated: true)
    }
    
    alert.addAction(confirmAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true)
  }
  
  private func configurePlayer(with url: String) {
    player.pause()
    playerLayer.removeFromSuperlayer()
    
    player = AVPlayer(url: URL(string: url)!)
    playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame = CGRect(x: 0, y: 0, width: playerView.bounds.width, height: playerView.bounds.height)
    playerView.layer.addSublayer(playerLayer)
    
    player.play()
  }
}

extension ViewController: LemonDeerDelegate {
  func videoDownloadSucceeded() {
    print("Video download succeeded.")
    
    isDownloading = false
    duringDownloadingProcess = false
    
    DispatchQueue.main.async {
      self.downloadButton.setTitle("Finished", for: .normal)
    }
    
    downloadButton.isUserInteractionEnabled = false
  }
  
  func videoDownloadFailed() {
    print("Video download failed.")
  }
  
  func update(_ progress: Float) {
    progressLabel.text = "\(progress * 100) %"
  }
}
