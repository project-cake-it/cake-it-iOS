//
//  LoginBackground.swift
//  cake-it
//
//  Created by seungbong on 2021/10/18.
//

import Foundation

struct LoginBackground {
  
  static let numberOfImages = 11
  
  static func randomBackground() -> UIImage? {
    let randNum = Int.random(in: 0..<numberOfImages)
    let numberString = (randNum<10) ? String("0\(randNum)") : String(randNum)
    let imageName = "loginBackground" + numberString
    
    return UIImage(named: imageName)
  }
}
