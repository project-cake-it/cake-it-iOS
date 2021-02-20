//
//  LoginModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/07.
//

import Foundation

final class LoginTestModel: BaseModel {
  
  let email: String
  let password: String
  
  init(email: String, password: String) {
    self.email = email
    self.password = password
  }
  
  struct Response: Decodable {
    let data: String
  }
}
