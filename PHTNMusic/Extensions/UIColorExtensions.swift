//
//  UIColorExtensions.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  func isLight() -> Bool {
    // Determine the components from a given URL.
    guard let components = cgColor.components else { return false }
    
    // The following algorithm is taken from a formula for converting RGB values to YIQ values. This brightness value gives a perceived brightness for a color.
    let redBrightness = components[0] * 299
    let greenBrightness = components[1] * 587
    let blueBrightness = components[2] * 114
    let brightness = (redBrightness + greenBrightness + blueBrightness) / 1000
    
    // Check the value to determine if the color is light by checking for a higher brightness level.
    return brightness > 0.5
  }
}
