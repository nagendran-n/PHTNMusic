//
//  Songs.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

// Song Model.
struct Song {
  var artworkUrl60: String = ""
  var collectionPrice: Double = 0.0
  var wrapperType: String = ""
  var country: String = ""
  var isStreamable: Bool = false
  var releaseDate: String = ""
  var artistId: Int = 0
  var collectionViewUrl: String = ""
  var kind: String = ""
  var trackExplicitness: String = ""
  var currency: String = ""
  var artistName: String = ""
  var artistViewUrl: String = ""
  var artworkUrl30: String = ""
  var trackViewUrl: String = ""
  var discCount: Int = 0
  var collectionCensoredName: String = ""
  var collectionId: Int = 0
  var trackCensoredName: String = ""
  var previewUrl: String = ""
  var trackTimeMillis: Int = 0
  var trackName: String = ""
  var trackPrice: Double = 0.0
  var collectionName: String = ""
  var artworkUrl100: String = ""
  var trackCount: Int = 0
  var trackId: Int = 0
  var discNumber: Int = 0
  var collectionExplicitness: String = ""
  var trackNumber: Int = 0
  var primaryGenreName: String = ""
}

// Song ObjectMapper visual model.
extension Song: Mappable {
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    artworkUrl60                <- map["artworkUrl60"]
    collectionPrice             <- map["collectionPrice"]
    wrapperType                 <- map["wrapperType"]
    country                     <- map["country"]
    isStreamable                <- map["isStreamable"]
    releaseDate                 <- map["releaseDate"]
    artistId                    <- map["artistId"]
    collectionViewUrl           <- map["collectionViewUrl"]
    kind                        <- map["kind"]
    trackExplicitness           <- map["trackExplicitness"]
    currency                    <- map["currency"]
    artistName                  <- map["artistName"]
    artistViewUrl               <- map["artistViewUrl"]
    trackViewUrl                <- map["trackViewUrl"]
    discCount                   <- map["discCount"]
    collectionCensoredName      <- map["collectionCensoredName"]
    collectionId                <- map["collectionId"]
    trackCensoredName           <- map["trackCensoredName"]
    previewUrl                  <- map["previewUrl"]
    trackTimeMillis             <- map["trackTimeMillis"]
    trackName                   <- map["trackName"]
    trackPrice                  <- map["trackPrice"]
    collectionName              <- map["collectionName"]
    artworkUrl100               <- map["artworkUrl100"]
    trackCount                  <- map["trackCount"]
    trackId                     <- map["trackId"]
    discNumber                  <- map["discNumber"]
    collectionExplicitness      <- map["collectionExplicitness"]
    trackNumber                 <- map["trackNumber"]
    primaryGenreName            <- map["primaryGenreName"]
  }
}

struct SearchResult {
  var songCount: Int = 0
  var songs: [Song] = []
}

// Lyric ObjectMapper visual model.
extension SearchResult: Mappable {
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    songCount <- map["resultCount"]
    songs     <- map["results"]
  }
}
