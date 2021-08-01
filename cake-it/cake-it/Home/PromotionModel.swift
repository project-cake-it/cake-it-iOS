//
//  PromotionResponse.swift
//  cake-it
//
//  Created by theodore on 2021/07/03.
//

import Foundation

struct PromotionModel: Codable {
  struct Response: Codable {
    let id: Int
    let imageUrl: String
    let designID: Int
    
    enum CodingKeys: String, CodingKey {
      case id
      case imageUrl
      case designID = "designId"
    }
  }
}
