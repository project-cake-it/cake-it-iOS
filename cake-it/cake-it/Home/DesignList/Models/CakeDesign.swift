//
//  CakeDesign.swift
//  cake-it
//
//  Created by Cory on 2021/03/25.
//

import Foundation

struct CakeDesign: Codable {
  let id: Int
  let name: String
  let themeNames: String
  let theme: String
  let category: String
  let color: String
  let designImages: [DesignImageInfo]
  let shopId: Int
  let shopName: String
  let shopAddress: String
  let shopPullAddress: String
  let sizes: [DesignSizeInfo]
  let creamNames: String
  let sheetNames: String
  let shopChannel: String
  let zzim: Bool

  struct DesignImageInfo: Codable {
    let id: Int
    let designImageUrl: String
  }

  struct DesignSizeInfo: Codable {
    let id: Int
    var name: String
    let price: Int
  }
  
  // Response
  struct Response: Decodable {
    let design: CakeDesign
  }
}
