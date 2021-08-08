//
//  GeoCoderManager.swift
//  cake-it
//
//  Created by theodore on 2021/08/07.
//

import Foundation
import CoreLocation

typealias GeoCoderCompletion = (Bool, CLLocation?) -> Void

class GeoCoderManager {
  
  static let shared = GeoCoderManager()
  private let geocoder = CLGeocoder()
  private let locations = NSMutableDictionary()
  
  private init() { }
  
  func getLocation(_ address: String, completion: @escaping GeoCoderCompletion){
    if let location = locations.value(forKey: address) as? CLLocation {
      completion(true, location)
      return
    }
    
    let changedString = formatedAddress(address)
    geocoder.geocodeAddressString(changedString) { placemark, error in
      if error != nil {
        completion(false, nil)
        return
      }
      
      guard let place = placemark?.first,
            let location = place.location else {
        completion(false, nil)
        return
      }
      
      // 좌표값을 저장한다.
      self.locations.setValue(location, forKey:address)
      print("\(changedString), \(location)")
      completion(true, location)
    }
  }
  
  private func formatedAddress(_ address: String) -> String {
    let stringArray = address.split(separator: " ")
    var newAddress = ""
    for index in 0..<stringArray.count {
      let string = stringArray[index]
      
      if string.contains("호") || string.contains("층") {
        break;
      }
      
      newAddress.append("\(string.description) ")
    }
    
    return newAddress.trimmingCharacters(in: .whitespaces)
  }
}
