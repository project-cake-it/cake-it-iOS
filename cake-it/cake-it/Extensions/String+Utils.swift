//
//  String+Utils.swift
//  cake-it
//
//  Created by seungbong on 2021/06/06.
//

import Foundation

extension String {
  /// 케이크 사이즈 정보에서 괄호를 제거한 String 반환 - ex) 미니(12cm) -> 미니 12cm
  func withoutParentheses() -> String {
    var convertedString = self.replacingOccurrences(of: "(", with: " ")
    convertedString = convertedString.replacingOccurrences(of: ")", with: "")
    
    return convertedString
  }
  
  func encodedString() -> String? {
    return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
  }
  
  mutating func dropFirst() {
    if self.count > 0 {
      self.remove(at: self.startIndex)
    }
  }
}
