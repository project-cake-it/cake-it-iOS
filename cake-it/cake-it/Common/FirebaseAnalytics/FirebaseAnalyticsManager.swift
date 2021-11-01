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
  
  func logContactShopEventInShopDetail(with detailData: CakeShop) {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = dateFormatter.string(from: currentDate)
    
    Analytics.logEvent(
      Event.contactShop,
      parameters: [
        "timestamp": dateString,
        "shop_id": detailData.id,
        "shop_name": detailData.name,
        "shop_address": detailData.address
      ])
  }

  func logContactShopEventInCakeDesignDetail(with detailData: CakeDesign) {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = dateFormatter.string(from: currentDate)
    
    Analytics.logEvent(
      Event.contactShop,
      parameters: [
        "timestamp": dateString,
        "shop_id": detailData.shopId,
        "shop_name": detailData.shopName,
        "shop_address": detailData.shopAddress,
        "design_id": detailData.id,
        "design_name": detailData.name
      ])
  }
}
