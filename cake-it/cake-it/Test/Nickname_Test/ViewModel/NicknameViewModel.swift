//
//  NicknameViewModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import Foundation

final class NicknameViewModel: BaseViewModel {
  
  var model: NicknameModel?
  
  override init() {
    model = NicknameModel()
  }
  
  func performGetNickname(completion: @escaping (String) -> Void) {
    
    NetworkManager.shared.requestGet(api: .randomNikname,
                                     type: NicknameModel.Response.self) { (response) in
      switch response {
      case .success(let result):
        print(result)
        completion(result.nickname)
      case .failure(let error):
        self.processingError(error: error.localizedDescription)
        break
      }
    }
  }
}
