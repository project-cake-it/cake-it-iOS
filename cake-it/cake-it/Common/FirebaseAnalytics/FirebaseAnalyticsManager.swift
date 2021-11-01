//
//  FirebaseAnalyticsManager.swift
//  cake-it
//
//  Created by Cory on 2021/10/25.
//

import Foundation
import Firebase

final class FirebaseAnalyticsManager {
  
  static let shared = FirebaseAnalyticsManager()
  
  private init() { }
  
  enum Event {
    static let contactShop = "contact_shop"
  }
  
  func logContactShopEventInShopDetail(shopID: String, shopName: String, shopAddress: String) {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = dateFormatter.string(from: currentDate)
    
    Analytics.logEvent(
      Event.contactShop,
      parameters: [
        "timestamp": dateString,
        "shop_id": shopID,
        "shop_name": shopName,
        "shop_address": shopAddress
      ])
  }

  func logContactShopEventInCakeDesignDetail(
    shopID: String,
    shopName: String,
    shopAddress: String,
    designID: String,
    designName: String) {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = dateFormatter.string(from: currentDate)
    
    Analytics.logEvent(
      Event.contactShop,
      parameters: [
        "timestamp": dateString,
        "shop_id": shopID,
        "shop_name": shopName,
        "shop_address": shopAddress,
        "design_id": designID,
        "design_name": designName
      ])
  }
}
