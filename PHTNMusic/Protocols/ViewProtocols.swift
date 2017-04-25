//
//  ViewProtocols.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import Foundation

/**
 Reusable View Protocol.
*/
protocol ReusableView: class {}

/**
 UIView loadable from Nib Protocol.
 */
protocol NibLoadableView: class { }

/**
 Indicator View Protocol.
 */
protocol IndicatableView: class {
  func showActivityIndicator()
  func hideActivityIndicator()
}
