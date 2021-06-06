//
//  CakeDesign.swift
//  cake-it
//
//  Created by Cory on 2021/03/25.
//

import Foundation

struct CakeDesign: Decodable {
  let image, location, size ,name: String
  let price: UInt
}
