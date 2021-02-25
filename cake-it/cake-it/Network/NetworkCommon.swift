//
//  NetworkCommon.swift-
//  cake-it
//
//  Created by seungbong on 2021/02/09.
//

import Foundation

class NetworkCommon {
  
  struct Response: Decodable {
    let status: Int
    let message: String
    let data: String
  }
  
  enum API: String {
    case loginTest = "http://13.124.173.58:8080/api/v2/login"
    case randomNikname = "http://13.124.173.58:8080/api/v2/nickname"
    
    var urlString: String {
      return self.rawValue
    }
  }
}