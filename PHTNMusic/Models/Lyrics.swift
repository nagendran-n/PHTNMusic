//
//  Lyrics.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import Foundation
import ObjectMapper

struct Lyric {
  var artist: String = ""
  var song: String = ""
  var lyrics: String = ""
  var url: String = ""
}

extension Lyric: Mappable {
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    artist  <- map["artist"]
    song    <- map["song"]
    lyrics  <- map["lyrics"]
    url     <- map["url"]
  }
}
