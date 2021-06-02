//
//  LoginType.swift
//  cake-it
//
//  Created by theodore on 2021/04/11.
//

import Foundation

enum LoginSocialType: String {
  case KAKAO  = "KAKAO"
  case NAVER  = "NAVER"
  case APPLE  = "APPLE"
  case GOOGLE = "GOOGLE"
  
  var string: String {
    return self.rawValue
  }
}
