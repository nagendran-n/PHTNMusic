//
//  LyricsRouter.swift
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
class LyricsRouter: LyricsWireframe {
  static func assembleModule(_ song: Song) -> UIViewController {
    // Retrieve the view controller from the storyboard.
    let storyboard: UIStoryboard = UIStoryboard(name: "LyricsStoryboard", bundle: Bundle.main)
    let lyricsViewController: LyricsViewController = storyboard.instantiateViewController(withIdentifier: "LyricsViewController") as! LyricsViewController
    
    // Set the base modules for a VIPER architecture.
    let view = lyricsViewController
    let presenter = LyricsPresenter()
    let interactor = LyricsInteractor()

    // Setup the presenter.
    view.presenter = presenter
    presenter.view = view
    presenter.interactor = interactor
    
    // Setup the interactor output.
    interactor.output = presenter

    // Set all public variables.
    presenter.song = song

    return view
  }
}
