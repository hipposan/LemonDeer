//
//  VideoDownloaderHelper.swift
//  WindmillComic
//
//  Created by Ziyi Zhang on 09/06/2017.
//  Copyright © 2017 Ziyideas. All rights reserved.
//

import Foundation

public func getDocumentsDirectory() -> URL {
  let paths = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask)
  let documentsDirectory = paths[0]
  return documentsDirectory
}
