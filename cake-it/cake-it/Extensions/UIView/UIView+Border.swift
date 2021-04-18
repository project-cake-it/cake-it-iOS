//
//  UIView+Border.swift
//  cake-it
//
//  Created by Cory on 2021/04/18.
//

import UIKit

extension UIView {
  
  enum Direction {
    case Top, Bottom, Leading, Trailing
  }
  
  func addBorder(side: Direction, borderColor: UIColor, borderWidth: CGFloat) {
    let border = CALayer()
    border.backgroundColor = borderColor.cgColor
    
    switch side {
    case .Top:
      border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
    case .Bottom:
      border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
    case .Leading:
      border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.size.height)
    case .Trailing:
      border.frame = CGRect(x: self.frame.size.width - borderWidth, y: 0, width: borderWidth, height: self.frame.size.height)
    }
    self.layer.addSublayer(border)
  }
}
