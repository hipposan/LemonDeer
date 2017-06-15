//
//  m3u8Handler.swift
//  WindmillComic
//
//  Created by hippo_san on 08/06/2017.
//  Copyright © 2017 Ziyideas. All rights reserved.
//

import Foundation

protocol M3u8ParserDelegate: class {
  func parseM3u8Succeeded(by parser: M3u8Parser)
  func parseM3u8Failed(by parser: M3u8Parser)
}

open class M3u8Parser {
  weak var delegate: M3u8ParserDelegate?
  
  var m3u8Data: String = ""
  var tsSegmentArray = [M3u8TsSegmentModel]()
  var tsPlaylist = M3u8Playlist()
  var identifier = ""
  
  open func parse(with url: String) {
    guard let m3u8ParserDelegate = delegate else {
      print("M3u8ParserDelegate not set.")
      return
    }
    
    if !(url.hasPrefix("http://") || url.hasPrefix("https://")) {
      print("Invalid URL.")
      m3u8ParserDelegate.parseM3u8Failed(by: self)
      return
    }
    
    do {
      let m3u8Content = try String(contentsOf: URL(string: url)!, encoding: .utf8)
      
      if m3u8Content == "" {
        print("Empty m3u8 content.")
        m3u8ParserDelegate.parseM3u8Failed(by: self)
        return
      } else {
        guard (m3u8Content.range(of: "#EXTINF:") != nil) else {
          print("No EXTINF info.")
          m3u8ParserDelegate.parseM3u8Failed(by: self)
          return
        }
        
        self.m3u8Data = m3u8Content
        if tsSegmentArray.count > 0 { tsSegmentArray.removeAll() }
        
        let segmentRange = m3u8Content.range(of: "#EXTINF:")!
        let segmentsString = String(m3u8Content.characters.suffix(from: segmentRange.lowerBound)).components(separatedBy: "#EXT-X-ENDLIST")
        var segmentArray = segmentsString[0].components(separatedBy: "\r\n")
        
        if segmentArray.contains("#EXT-X-DISCONTINUITY") {
          segmentArray = segmentArray.filter { $0 != "#EXT-X-DISCONTINUITY" }
        }
        
        while (segmentArray.count > 2) {
          var segmentModel = M3u8TsSegmentModel()
          
          let segmentDurationPart = segmentArray[0].components(separatedBy: ":")[1]
          var segmentDuration: Float = 0.0
          
          if segmentDurationPart.contains(",") {
            segmentDuration = Float(segmentDurationPart.components(separatedBy: ",")[0])!
          } else {
            segmentDuration = Float(segmentDurationPart)!
          }
          
          let segmentURL = segmentArray[1]
          segmentModel.duration = segmentDuration
          segmentModel.locationURL = segmentURL
          
          tsSegmentArray.append(segmentModel)
          
          segmentArray.remove(at: 0)
          segmentArray.remove(at: 0)
        }
        
        tsPlaylist.initSegment(with: tsSegmentArray)
        tsPlaylist.identifier = identifier
        
        m3u8ParserDelegate.parseM3u8Succeeded(by: self)
      }
    } catch let error {
      print(error.localizedDescription)
      print("Read m3u8 file content error.")
    }
    
    
  }
  
}
