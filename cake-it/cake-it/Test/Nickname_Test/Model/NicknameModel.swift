//
//  NicknameModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import Foundation

final class NicknameModel: BaseModel {
  
  var randNum: Int?
  var nickname: String?
  
  override init() {
    super.init()
    randNum = Int.random(in: 0..<10)
  }
}
