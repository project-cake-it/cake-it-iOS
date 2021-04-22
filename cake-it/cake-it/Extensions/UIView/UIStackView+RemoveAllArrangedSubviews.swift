//
//  UIStackView+RemoveAllArrangedSubviews.swift
//  cake-it
//
//  Created by Cory on 2021/04/18.
//

import UIKit

extension UIStackView {
  func removeAllArrangedSubviews() {
    self.arrangedSubviews.forEach {
      $0.removeFromSuperview()
    }
  }
}
