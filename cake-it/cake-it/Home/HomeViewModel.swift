//
//  HomeViewModel.swift
//  cake-it
//
//  Created by theodore on 2021/07/03.
//

import Foundation

final class HomeViewModel: BaseViewModel {
  
  typealias CommonCompletion = (Bool, [PromotionModel.Response]?, Error?) -> Void
  
  func requestPromotionImage(completion: @escaping CommonCompletion){
    NetworkManager.shared.requestGet(api: .promotionImage,
                                     type: [PromotionModel.Response].self) { (result) in
      switch result {
      case .success(let result):
        completion(true, result, nil)
      case .failure(let error):
        completion(false, nil, error)
        break
      }
    }
  }
}
