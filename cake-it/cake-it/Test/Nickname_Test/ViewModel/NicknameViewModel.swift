//
//  NicknameViewModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import Foundation

final class NicknameViewModel {
  
  var model: NicknameModel?
  
  init() {
    model = NicknameModel()
  }
  
  func performGetNickname(completion: @escaping (String) -> Void) {
//    NetworkManager.shared.requestGet(api: .randomNikname, completion: { result in
//      switch result {
//
//      case .success(let response):
//        if let randName: String = response.data {
//          let userNickname = "\(randName)\(self.model?.randNum ?? 0)"
//          completion(userNickname)
//        }
//      case .failure(_):
//        // error 처리
//        break
//      }
//    })
  }
}
