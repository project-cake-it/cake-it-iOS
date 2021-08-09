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
  let operationTime, pickupTime, telephone: String
  let shopChannel: String
  let shopImages: [CakeShopImage]
  let themeNames: String
  let hashtags: [CakeShopHashtag]
  let sizes: [CakeShopCakeSize]
  let displaySize: CakeShopCakeSize
  let orderAvailableDates: [String]
  let creamNames, sheetNames: String
  let zzim: Bool
  let zzimCount: Int
  let designs: [CakeShopCakeDesign]
  let urlX, urlY: String
  
  enum CodingKeys: String, CodingKey {
    case id, name, address, fullAddress, information, holiday, operationTime, pickupTime, telephone, shopChannel, shopImages, themeNames, hashtags, sizes, displaySize, creamNames, sheetNames, zzim, zzimCount, designs, urlX, urlY
    case orderAvailableDates = "orderAvailabilityDates"
  }
}

struct CakeShopCakeDesign: Decodable {
  let id: Int
  let name: String
  let designImage: CakeShopCakeDesignImage?
}

struct CakeShopCakeDesignImage: Decodable {
  let id: Int
  let designImageURL: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case designImageURL = "designImageUrl"
  }
}

struct CakeShopHashtag: Decodable {
  let id: Int
  let name: String
}

struct CakeShopImage: Decodable {
  let id: Int
  let shopImageURL: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case shopImageURL = "shopImageUrl"
  }
}

struct CakeShopCakeSize: Decodable {
  let id: Int
  let name, size: String
  let price: Int
}
