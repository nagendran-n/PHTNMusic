//
//  SongsContract.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import UIKit
import PHTNNetwork

//TODO: Move this class to a separate framework to separate concerns.

/**
 This class contains the contract definition for the Song Search module.
 The class describes the following sub-classes:
 important: SongsView - The base View protocol with reference to the Presenter and the list of public methods.
 important: SongsPresentation - The base Presentation protocol with references to the View, Interactor and any View/ViewController-related public methods.
 important: SongsUseCase: The base protocol containging reference to the Interactor Output.
 important: SongsInteractorOutput: The base protocol containing the delegate methods to capture the result of the service calls.
 important: SongsWireframe: The base protocol containing the UI rendering methods.
 */

protocol SongsView: IndicatableView {
  var presenter: SongsPresentation! { get set }
  
  func showNoContentScreen()
  func showSongsData(_ searchResult: SearchResult)
}

protocol SongsPresentation: class {
  weak var view: SongsView? { get set }
  var interactor: SongsUseCase! { get set }
  var router: SongsWireframe! { get set }

  func searchFor(keywords: String)
  func didSelectSong(_ song: Song)
}

protocol SongsUseCase: class {
  weak var output: SongsInteractorOutput! { get set }
  
  func fetchSongs(keywords: String)
}

protocol SongsInteractorOutput: class {
  func songsFetched(_ searchResult: SearchResult)
  func songsFetchFailed()
}

protocol SongsWireframe: class {
  weak var viewController: UIViewController? { get set }
  
  func presentLyrics(forSong song: Song)
  
  static func assembleModule() -> UIViewController
}
