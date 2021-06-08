//
//  LoginType.swift
//  cake-it
//
//  Created by theodore on 2021/04/11.
//

import Foundation

enum LoginSocialType: String, CustomStringConvertible{
  var description: String {
    return self.rawValue
  }
  
  case KAKAO  = "KAKAO"
  case NAVER  = "NAVER"
  case APPLE  = "APPLE"
  case GOOGLE = "GOOGLE"
}
