//
//  LyricsPresenter.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import Foundation
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
class LyricsPresenter: LyricsPresentation {
  weak var view: LyricsView?
  var interactor: LyricsUseCase!
  var router: LyricsWireframe!

  
  var song: Song! {
    // When the song variable is set, fetch the lyrics for the given song.
    didSet {
      interactor.fetchLyrics(for: song.trackName, by: song.artistName)
    }
  }
  
  var searchResult: Lyric! {
    // When the search result variable is set, show the lyric.
    didSet {
      view?.showLyrics(forSong: self.song, with: searchResult)
    }
  }
  
  func viewDidLoad() {
    // Method not needed.
  }
  
  func search(for song: String, by artist: String) {
    // Call the Data Loader method to retrieve the data.
    interactor.fetchLyrics(for: song, by: artist)
    
    // Show the activity indicator.
    view?.showActivityIndicator()
  }
}

extension LyricsPresenter: LyricsInteractorOutput {
  func lyricsFetched(_ searchResult: Lyric) {
    // Set the SearchResult variable with the result from the service.
    self.searchResult = searchResult
    
    // Hide the displayed activity indicator.
    view?.hideActivityIndicator()
  }
  
  internal func lyricsFetchFailed() {
    // Hide the displayed activity indicator.
    view?.hideActivityIndicator()
  }
}
