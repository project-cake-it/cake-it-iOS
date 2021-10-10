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
  
  static let BASE_URL = "http://cake-it.shop:8080/api/v2/"
  
  enum API: String {
    case login            = "login"             // 로그인
    case promotionImage   = "promotions"        // 프로모션 조회
    case bestDesigns      = "designs?order=best"
    case designs          = "designs"           // 디자인 조회
    case shops            = "shops"             // 가게 조회
    case savedDesigns     = "zzim/designs"      // 찜한 디자인 조회
    case savedShops       = "zzim/shops"        // 찜한 가게 조회
    case search           = "search"            // 통합검색
    case notices          = "notices"           // 공지사항
    
    var urlString: String {
      return BASE_URL + self.rawValue
    }
  }
}
