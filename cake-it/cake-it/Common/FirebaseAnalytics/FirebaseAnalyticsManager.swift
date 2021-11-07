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
  
  func logContactShopEvent(withCakeShop cakeShop: CakeShop) {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = dateFormatter.string(from: currentDate)
    
    Analytics.logEvent(
      Event.contactShop,
      parameters: [
        "timestamp": dateString,
        "shop_id": cakeShop.id,
        "shop_name": cakeShop.name,
        "shop_address": cakeShop.address
      ])
  }

  func logContactShopEvent(withCakeDesign cakeDesign: CakeDesign) {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = dateFormatter.string(from: currentDate)
    
    Analytics.logEvent(
      Event.contactShop,
      parameters: [
        "timestamp": dateString,
        "shop_id": cakeDesign.shopId,
        "shop_name": cakeDesign.shopName,
        "shop_address": cakeDesign.shopAddress,
        "design_id": cakeDesign.id,
        "design_name": cakeDesign.name
      ])
  }
}
