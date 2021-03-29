//
//  Fonts.swift
//  cake-it
//
//  Created by Cory on 2021/03/28.
//

import UIKit

enum Fonts {
  enum Weight: String, CustomStringConvertible {
    case Thin = "Thin"
    case Light = "Light"
    case Regular = "Regular"
    case Medium = "Medium"
    case Bold = "Bold"
    
    var description: String {
      return self.rawValue
    }
  }
  
  static func spoqaHanSans(weight: Weight, size: CGFloat) -> UIFont {
    return UIFont(name: "SpoqaHanSansNeo-\(weight)", size: size)!
  }
}
