//
//  LyricsContract.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import UIKit
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
protocol LyricsView: IndicatableView {
  var presenter: LyricsPresentation! { get set }

  func showLyrics(forSong song: Song, with lyric: Lyric)
}

protocol LyricsPresentation: class {
  weak var view: LyricsView? { get set }
  var interactor: LyricsUseCase! { get set }

  func viewDidLoad()
  func search(for song: String, by artist: String)
}

protocol LyricsUseCase: class {
  weak var output: LyricsInteractorOutput! { get set }
  
  func fetchLyrics(for song: String, by artist: String)
}

protocol LyricsInteractorOutput: class {
  func lyricsFetched(_ searchResult: Lyric)
  func lyricsFetchFailed()
}

protocol LyricsWireframe: class {
  static func assembleModule(_ song: Song) -> UIViewController
}
