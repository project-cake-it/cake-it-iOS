//
//  UIView+Border.swift
//  cake-it
//
//  Created by Cory on 2021/04/18.
//

import UIKit

extension UIView {
  
  enum Direction {
    case top, bottom, leading, trailing
  }
  
  func addBorder(borderColor: UIColor, borderWidth: CGFloat) {
    self.layer.borderColor = borderColor.cgColor
    self.layer.borderWidth = borderWidth
  }
  
  func addBorder(side: Direction, borderColor: UIColor, borderWidth: CGFloat) {
    let border = CALayer()
    border.backgroundColor = borderColor.cgColor
    
    switch side {
    case .top:
      border.frame = CGRect(x: 0,
                            y: 0,
                            width: frame.size.width,
                            height: borderWidth)
    case .bottom:
      border.frame = CGRect(x: 0,
                            y: self.frame.size.height - borderWidth,
                            width: self.frame.size.width,
                            height: borderWidth)
    case .leading:
      border.frame = CGRect(x: 0,
                            y: 0,
                            width: borderWidth,
                            height: self.frame.size.height)
    case .trailing:
      border.frame = CGRect(x: self.frame.size.width - borderWidth,
                            y: 0,
                            width: borderWidth,
                            height: self.frame.size.height)
    }
    self.layer.addSublayer(border)
  }
}
