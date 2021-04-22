//
//  LoginModel.swift
//  cake-it
//
//  Created by theodore on 2021/03/21.
//

import Foundation

final class LoginModel: BaseModel {
  
  let accessToken: String
  let socialType: String
  
  init(accessToken: String, type: String) {
    self.accessToken = accessToken
    self.socialType = type
  }
  
  struct Response: Decodable {
    let accessToken: String
  }
}
