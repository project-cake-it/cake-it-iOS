//
//  LoginModel.swift
//  cake-it
//
//  Created by theodore on 2021/03/21.
//

import Foundation

final class LoginModel: BaseModel {
  
  let authCode: String
  let socialType: String
  
  init(token: String, type: String) {
    self.authCode = token
    self.socialType = type
  }
  
  struct Response: Decodable {
    let token: String
  }
}
