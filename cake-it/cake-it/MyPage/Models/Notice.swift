//
//  Notice.swift
//  cake-it
//
//  Created by theodore on 2021/07/10.
//

import Foundation

struct Notice: Decodable {
  let id: Int
  let title: String
  let body: String
  let createdAt: String
}
