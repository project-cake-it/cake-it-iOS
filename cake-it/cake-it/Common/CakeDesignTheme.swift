//
//  CakeDesignTheme.swift
//  cake-it
//
//  Created by theodore on 2021/06/18.
//

import Foundation

enum CakeDesignTheme: String, CustomStringConvertible {
  var description: String {
    return self.rawValue
  }
  
  case birthDay = "생일"
  case anniversary = "기념일"
  case wedding = "웨딩"
  case promotion = "입사/승진"
  case resignation = "복직/퇴사"
  case discharge = "전역"
  case society = "동아리/모임"
  case etc = "기타"
}
