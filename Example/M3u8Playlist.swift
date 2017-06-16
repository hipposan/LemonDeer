//
//  M3u8Playlist.swift
//  WindmillComic
//
//  Created by hippo_san on 08/06/2017.
//  Copyright © 2017 Ziyideas. All rights reserved.
//

import Foundation

class M3u8Playlist {
  var tsSegmentArray = [M3u8TsSegmentModel]()
  var length = 0
  var identifier = ""
  
  func initSegment(with array: [M3u8TsSegmentModel]) {
    tsSegmentArray = array
    length = array.count
  }
}
