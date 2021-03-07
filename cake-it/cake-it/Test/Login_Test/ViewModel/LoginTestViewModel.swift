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
                                      type: LoginTestModel.Response.self,
                                      param: model) { (response) in
      switch response {
      case .success(let result):
        let token = result.token
        completion(token)
      case .failure(let error):
        self.processingError(error: error.localizedDescription)
        break
      }
    }
  }
}
