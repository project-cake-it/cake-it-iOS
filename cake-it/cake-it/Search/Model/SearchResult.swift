//
//  SearchResult.swift
//  cake-it
//
//  Created by seungbong on 2021/07/11.
//

import Foundation

final class SearchResult: Decodable {
  var designs: [CakeDesign]
  var shops: [CakeShop]
} 
