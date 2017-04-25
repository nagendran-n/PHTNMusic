//
//  LyricsAPIService.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift

/**
 This class contains the contract definition for the Lyrics module.
 The class describes the following sub-classes:
 important: LyricsView - The base View protocol with reference to the Presenter and the list of public methods.
 important: LyricsPresentation - The base Presentation protocol with references to the View, Interactor and any View/ViewController-related public methods.
 important: LyricsUseCase: The base protocol containging reference to the Interactor Output.
 important: LyricsInteractorOutput: The base protocol containing the delegate methods to capture the result of the service calls.
 important: LyricsWireframe: The base protocol containing the UI rendering methods.
 */
class LyricsAPIService {
  static func fetchLyrics(for song: String, by artist: String) -> Observable<Lyric> {
    return Observable<Lyric>.create { observer -> Disposable in
      var url = Endpoints.Lyrics.fetch.url
      url = url
        .replacingOccurrences(of: "<song>", with: song.replacingOccurrences(of: " ", with: "+"))
        .replacingOccurrences(of: "<artist>", with: artist.replacingOccurrences(of: " ", with: "+"))
      
      let request = Alamofire
        .request(url, method: .get)
        .validate()
        .responseString(completionHandler: { (response) in
          var lyrics = response.result.value
          
          switch response.result {
          case .success(_):
            lyrics = lyrics?
              .replacingOccurrences(of: "song = ", with: "")
              .replacingOccurrences(of: "\'", with: "\"")

            let lyricObject = Lyric(JSONString: lyrics!)
            observer.onNext(lyricObject!)
            observer.onCompleted()
            
          case .failure(let error):
            observer.onError(error)
          }

        })
      
      return Disposables.create(with: {
        request.cancel()
      })
    }
  }
}
