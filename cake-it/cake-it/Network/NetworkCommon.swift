//
//  NetworkCommon.swift-
//  cake-it
//
//  Created by seungbong on 2021/02/09.
//

import Foundation

class NetworkCommon {
  
  struct Response<T: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T
  }
  
  static let BASE_URL = "http://13.124.173.58:8080/api/v2/"
  
  enum API: String {
    case login = "login"
    case designs = "designs"
    case shops = "shops"
    case savedDesigns = "zzim/designs"
    case savedShops = "zzim/shops"

    case randomNikname = "nickname"
    case uploadPhoto = "test/post"
    
    case bestDesigns = "designs?order=best"
    case promotionImage = "promotions"
    
    var urlString: String {
      return BASE_URL + self.rawValue
    }
  }
}
