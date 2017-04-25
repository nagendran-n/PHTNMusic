//
//  SongsPresenter.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import Foundation
import PHTNNetwork

//TODO: Move this class to a separate framework to separate concerns.

/**
 This class contains the presenter definition for the Songs module.
 */
class SongsPresenter: SongsPresentation {
  weak var view: SongsView?
  var interactor: SongsUseCase!
  var router: SongsWireframe!
  
  var searchResult: SearchResult! {
    // When the search result variable is set, perform certain operations.
    didSet {
      // Check if more than one song is returned.
      if searchResult.songCount > 0 {
        // Show the songs data in the view.
        view?.showSongsData(searchResult)
      } else {
        // Show a NoData view when the search term returns an empty dataset or errors out.
        view?.showNoContentScreen()
      }
    }
  }
  
  func viewDidLoad() {
    // Method not needed.
  }
  
  // Call the Data Loader method to retrieve the data.
  func searchFor(keywords: String) {
    // Make the service call through the interactor.
    interactor.fetchSongs(keywords: keywords)
    
    // Show the activity indicator.
    view?.showActivityIndicator()
  }
  
  func didSelectSong(_ song: Song) {
    // Show the lyrics in a new view controller.
    router.presentLyrics(forSong: song)
  }
}

extension SongsPresenter: SongsInteractorOutput {
  func songsFetched(_ searchResult: SearchResult) {
    // Set the SearchResult variable with the result from the service.
    self.searchResult = searchResult
    
    // Hide the displayed activity indicator.
    view?.hideActivityIndicator()
  }
  
  internal func songsFetchFailed() {
    // Show a NoData view when the search term returns an empty dataset or errors out.
    view?.showNoContentScreen()
    
    // Hide the displayed activity indicator.
    view?.hideActivityIndicator()
  }
}
