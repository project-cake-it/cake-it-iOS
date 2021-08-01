//
//  MyPageViewModel.swift
//  cake-it
//
//  Created by theodore on 2021/07/10.
//

import Foundation

final class MyPageViewModel: BaseViewModel {
  
  typealias CommonCompletion = (Bool, [Notice]?, Error?) -> Void
  
  func requestNotices(completion: @escaping CommonCompletion) {
    NetworkManager.shared.requestGet(api: .notices,
                                     type: [Notice].self) { result in
      switch result {
      case .success(let result):
        completion(true, result, nil)
        break
      case .failure(let error):
        completion(false, nil, error)
        break
      }
    }
  }
}
