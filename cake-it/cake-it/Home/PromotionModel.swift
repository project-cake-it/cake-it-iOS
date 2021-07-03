//
//  PromotionResponse.swift
//  cake-it
//
//  Created by theodore on 2021/07/03.
//

import Foundation

struct PromotionModel: Encodable {
  struct Response: Codable {
    let id: Int
    let imageUrl: String
    let link: String
  }
}
