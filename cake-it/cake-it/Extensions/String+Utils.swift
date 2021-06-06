//
//  String+Utils.swift
//  cake-it
//
//  Created by seungbong on 2021/06/06.
//

import Foundation

extension String {
  func removeBracketInSizeInfo() -> String {
    var convertedString = self.replacingOccurrences(of: "(", with: " ")
    convertedString = convertedString.replacingOccurrences(of: ")", with: "")
    
    return convertedString
  }
}
