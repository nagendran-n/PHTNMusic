//
//  LyricsInteractor.swift
//  PHTNMusic
//
//  Created by Nags on 4/22/17.
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
 This class contains the contract definition for the Lyrics module.
 The class describes the following sub-classes:
 important: LyricsView - The base View protocol with reference to the Presenter and the list of public methods.
 important: LyricsPresentation - The base Presentation protocol with references to the View, Interactor and any View/ViewController-related public methods.
 important: LyricsUseCase: The base protocol containging reference to the Interactor Output.
 important: LyricsInteractorOutput: The base protocol containing the delegate methods to capture the result of the service calls.
 important: LyricsWireframe: The base protocol containing the UI rendering methods.
 */
class LyricsInteractor: LyricsUseCase {
  weak var output: LyricsInteractorOutput!
  private var disposeBag = DisposeBag()
  
  func fetchLyrics(for song: String, by artist: String) {
    LyricsAPIService
      // Fetch the lyric of a song by calling the Lyrics Search API for the provided song title and artist name.
      .fetchLyrics(for: song, by: artist)

      // Subscribe to an observable (we are using ReactiveX Observable here so that we can receive data elements asynchronously which a Sequence cannot.
      .subscribe(
        // Add all the output rows.
        onNext: { searchResult in
          // Call the delegate method with the search result.
          self.output.lyricsFetched(searchResult)
      },
        // In case of an error, call the delegate method to indicate failure.
        onError: { error in
          self.output.lyricsFetchFailed()
      })

      // Setup a disposable bag.
      .addDisposableTo(disposeBag)
  }
}
