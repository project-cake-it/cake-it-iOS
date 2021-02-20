//
//  LoginTestViewModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import Foundation

final class LoginTestViewModel: BaseViewModel {
  
  private var model: LoginTestModel?
  
  func performLoginTest(email: String, password: String, completion: @escaping (String) -> Void) {
    model = LoginTestModel(email: email, password: password)
    NetworkManager.shared.requestPost(api: .loginTest,
                                      type: String.self,
                                      param: model) { (result) in
      switch result {
      case .success(let response):
        let token = response
        completion(token)
      case .failure(_):
        // error 처리
        break
      }
    }
  }
}
