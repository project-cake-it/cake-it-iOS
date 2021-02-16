//
//  LoginModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/07.
//

import Foundation

class LoginTestModel: BaseModel {
    
    // MARK:- Network Request
    var email: String?
    var password: String?
    
    override init() { }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    
    // MARK:- Network Response
    struct LoginInfo: Decodable {
        var data: String?
    }
}
