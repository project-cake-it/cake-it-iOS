//
//  UIView+RoundCorner.swift
//  cake-it
//
//  Created by Cory on 2021/03/26.
//

import UIKit

extension UIView {
  func round(cornerRadius: CGFloat,
             clipsToBounds: Bool = false,
             maskedCorners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]) {
    self.layer.cornerRadius = cornerRadius
    self.layer.maskedCorners = maskedCorners
    self.clipsToBounds = clipsToBounds
  }
}
