//
//  RootRouter.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
  func presentSongsScreen(in window: UIWindow) {
    window.makeKeyAndVisible()
    window.rootViewController = SongsRouter.assembleModule()
  }
}
