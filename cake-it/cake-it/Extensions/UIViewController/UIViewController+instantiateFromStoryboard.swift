//
//  UIViewController+instantiateFromStoryboard.swift
//  cake-it
//
//  Created by Cory on 2021/03/17.
//

import UIKit

extension UIViewController {
  static func instantiate(from storyboard: String) -> Self {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    let identifier = String(describing: Self.self)
    let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    return viewController
  }
}
