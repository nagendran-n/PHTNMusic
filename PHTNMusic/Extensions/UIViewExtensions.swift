//
//  IndicatableViewExtension.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import UIKit
import MBProgressHUD


extension IndicatableView where Self: UIViewController {
  /**
   Shows an activity indicator in the current view.
  */
  func showActivityIndicator() {
    // Display a HUD on the current view.
    MBProgressHUD.showAdded(to: self.view, animated: true)
  }
  
  /**
   Hides an activity indicator in the current view.
  */
  func hideActivityIndicator() {
    // Hides the HUD displayed in the current view.
    MBProgressHUD.hide(for: self.view, animated: true)
  }
}


extension ReusableView where Self: UIView {
  // A ststic variable that provides a reusable identifier for any View.
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension NibLoadableView where Self: UIView {
  // A static variable that provides a named Nib loadable option to any view.
  static var NibName: String {
    return String(describing: self)
  }
}

// UITableViewCell extensions to enable reusability and a Nib loadable view.
extension UITableViewCell: ReusableView { }
extension UITableViewCell: NibLoadableView { }


extension UITableView {
  /** 
   Registers a UIView to be displayed as UITableView cell content.
   - parameters:
     - T
   */
  func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
    let Nib = UINib(nibName: T.NibName, bundle: nil)
    register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  /**
   */
  func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    
    return cell
  }
}
