//
//  SongsAPIService.swift
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
class SongsAPIService {
  static func fetchSongs(keywords: String) -> Observable<SearchResult> {
    return Observable<SearchResult>.create { observer -> Disposable in
      let url = Endpoints.Songs.fetch.url
        .replacingOccurrences(of: "<keywords>", with: keywords)
        .replacingOccurrences(of: " ", with: "+")

      let request = Alamofire
        .request(url, method: .get)
        .validate()
        .responseObject(completionHandler: { (response: DataResponse<SearchResult>) in
          switch response.result {
          case .success(let searchResult):
            observer.onNext(searchResult)
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
