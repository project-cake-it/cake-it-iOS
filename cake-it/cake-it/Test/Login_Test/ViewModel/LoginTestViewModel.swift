//
//  LoginTestViewModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import Foundation

class LoginTestViewModel: BaseViewModel {
    
    var model: LoginTestModel?
    
    func performLoginTest(email: String, pw: String, complition: @escaping (String) -> Void) {
        model = LoginTestModel(email: email, password: pw)
        
        NetworkManager.shared.requestPost(api: .loginTest, param: model, completion: { response in
            guard let token = response.data else {
                self.processingError(error: "Data is nil")
                return
            }
            complition(token)
        })
    }
}
