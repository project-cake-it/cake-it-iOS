//
//  CakeShop.swift
//  cake-it
//
//  Created by Cory on 2021/04/06.
//

import Foundation

struct CakeShopDetailResponse: Decodable {
  let cakeShop: CakeShop
  
  enum CodingKeys: String, CodingKey {
    case cakeShop = "shop"
  }
}

struct CakeShop: Decodable {
  let id: Int
  let name, address, fullAddress, information, holiday: String
  let operationTime, pickupTime, telephone, kakaoMap: String
  let shopChannel: String
  let shopImages: [CakeShopImage]
  let themeNames: String
  let hashtags: [CakeShopHashtag]
  let sizes: [CakeShopCakeSize]
  let creamNames, sheetNames: String
  let zzim: Bool
  let zzimCount: Int
  let designs: [CakeShopCakeDesign]
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
