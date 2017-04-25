//
//  Endpoints.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import Foundation

/**
 Static URLs.
*/
struct API {
  static let songsBaseUrl = "https://itunes.apple.com"
  static let lyricsBaseUrl = "http://lyrics.wikia.com/api.php?func=getSong&artist=Tom+Waits&song=new+coat+of+paint&fmt=json"
}

/**
 Endpoint Protocol.
 */
protocol Endpoint {
  // Path to the query.
  var path: String { get }
  
  // Full URL of the service endpoint.
  var url: String { get }
}

/**
 Endpoint enumeration containing the endpoints for the Songs Search service and Lyrics service.
 */
enum Endpoints {
  enum Songs: Endpoint {
    case fetch
    
    public var path: String {
      switch self {
      case .fetch: return "/search?term=<keywords>"
      }
    }
    
    public var url: String {
      switch self {
      case .fetch: return "\(API.songsBaseUrl)\(path)"
      }
    }
  }
  
  enum Lyrics: Endpoint {
    case fetch
    
    public var path: String {
      switch self {
      case .fetch: return "/api.php?func=getSong&artist=<artist>&song=<song>&fmt=json"
      }
    }
    
    public var url: String {
      switch self {
      case .fetch: return "\(API.lyricsBaseUrl)\(path)"
      }
    }
  }
}
