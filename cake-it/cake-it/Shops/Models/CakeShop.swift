//
//  CakeShop.swift
//  cake-it
//
//  Created by Cory on 2021/04/06.
//

import Foundation

struct CakeShop: Decodable {
  let id: Int
  let name, address, pullAddress, information: String
  let operationTime, pickupTime, telephone, kakaoMap: String
  let shopChannel: String
  let shopImages: [CakeShopImage]
  let themeNames: CakeShopTheme
  let hashtags: [CakeShopHashtag]
  let sizes: [CakeShopCakeSize]
  let creamNames, sheetNames: String
  let zzimCount: Int
  let designs: [CakeShopCakeDesign]
  let zzim: Bool
}

struct CakeShopCakeDesign: Codable {
  let id: Int
  let name: String
  let designImage: CakeShopCakeDesignImage
}

struct CakeShopCakeDesignImage: Codable {
  let id: Int
  let designImageURL: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case designImageURL = "designImageUrl"
  }
}

struct CakeShopHashtag: Codable {
  let id: Int
  let name: String
}

struct CakeShopImage: Codable {
  let id: Int
  let shopImageURL: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case shopImageURL = "shopImageUrl"
  }
}

struct CakeShopCakeSize: Codable {
  let id: Int
  let name, size: String
  let price: Int
}

enum CakeShopTheme: String, Codable {
  case 화이트 = "#화이트"
}
