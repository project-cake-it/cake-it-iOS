//
//  UIDevice+hasNotch.swift
//  cake-it
//
//  Created by Cory on 2021/05/10.
//

import UIKit

extension UIDevice {
  var hasNotch: Bool {
    let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    return bottom > 0
  }
  
  static let minimumBottomSpaceInNotchDevice: CGFloat = 16
}
