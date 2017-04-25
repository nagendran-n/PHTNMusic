//
//  SongsRouter.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import UIKit
import PHTNNetwork

//TODO: Move this class to a separate framework to separate concerns.

/**
 This class contains the router definition for the Songs module.
 */
class SongsRouter: SongsWireframe {
  weak var viewController: UIViewController?
  
  static func assembleModule() -> UIViewController {
    // Retrieve the view controller from the storyboard.
    let storyboard: UIStoryboard = UIStoryboard(name: "SongsStoryboard", bundle: Bundle.main)
    let songsViewController: SongsViewController = storyboard.instantiateViewController(withIdentifier: "SongsViewController") as! SongsViewController
    
    // Set the base modules for a VIPER architecture.
    let view = songsViewController
    let presenter = SongsPresenter()
    let interactor = SongsInteractor()
    let router = SongsRouter()
    
    // Create a navigation controller to load the main view.
    let navigation = UINavigationController(rootViewController: view)
    
    // Setup the presenter.
    view.presenter = presenter
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router

    // Setup the interactor output.
    interactor.output = presenter
    
    // Setup the router view.
    router.viewController = view
    
    return navigation
  }
  
  
  func presentLyrics(forSong song: Song) {
    // Load the Lyrics view controller.
    let lyricsModuleViewController = LyricsRouter.assembleModule(song)
    viewController?.navigationController?.pushViewController(lyricsModuleViewController, animated: true)
  }
}
