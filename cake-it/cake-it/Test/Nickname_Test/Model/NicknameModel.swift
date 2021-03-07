//
//  NicknameModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import Foundation

final class NicknameModel: BaseModel {
  
  struct Response: Decodable {
    let nickname: String
  }
}
