//
//  SongsInteractor.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift
import PHTNNetwork

//TODO: Move this class to a separate framework to separate concerns.

/**
 This class contains the interactor definition for the Songs module.
 */
class SongsInteractor: SongsUseCase {
  weak var output: SongsInteractorOutput!
  private var disposeBag = DisposeBag()
  
  func fetchSongs(keywords: String) {
    SongsAPIService
      // Fetch the list of songs by calling the Songs Search API for the provided search terms.
      .fetchSongs(keywords: keywords)
      
      // Subscribe to an observable (we are using ReactiveX Observable here so that we can receive data elements asynchronously which a Sequence cannot.
      .subscribe(
        // Add all the output rows.
        onNext: { searchResult in
          // Call the delegate method with the search result.
          self.output.songsFetched(searchResult)
      },
        // In case of an error, call the delegate method to indicate failure.
        onError: { error in
          self.output.songsFetchFailed()
      }
      )
      
      // Setup a disposable bag.
      .addDisposableTo(disposeBag)
  }
}
