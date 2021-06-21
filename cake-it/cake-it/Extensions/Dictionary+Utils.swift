//
//  Dictionary+Utils.swift
//  cake-it
//
//  Created by seungbong on 2021/06/12.
//

import Foundation

extension Dictionary {

  /// Dictionary의 값으로 BaseURL을 제외한 queryString을 반환한다.
  /// ex)  [color: [PURLPLE, RED], locatrion: [관악구]] ->  ?color=PURPLE&color=RED&location=관악구
  func queryString() -> String {
    var queryString = "?"
    for (key, value) in self {
      // key값이 배열로 들어오는 경우
      if let values = value as? [String] {
        for value in values {
          queryString += "\(key)=\(value)&"
        }
      }
      // key 값이 String 으로 들어오는 경우
      else {
        queryString += "\(key)=\(value)&"
      }
    }
    queryString.removeLast()
    return queryString
  }
}
