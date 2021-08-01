//
//  UIView+AnimateCurveEaseOut.swift
//  cake-it
//
//  Created by Cory on 2021/08/01.
//

import UIKit

extension UIView {
  static func animateCurveEaseOut(withDuration: TimeInterval,
                                  delay: TimeInterval = 0.0,
                                  animation: @escaping () -> Void,
                                  completion: @escaping () -> Void = { }
  ) {
    UIView.animate(withDuration: withDuration,
                   delay: delay,
                   usingSpringWithDamping: 1.0,
                   initialSpringVelocity: 1.0,
                   options: .curveEaseOut
    ) {
      animation()
    } completion: { (_) in
      completion()
    }
  }
}

