//
//  PhotoUploadModel.swift
//  cake-it
//
//  Created by seungbong on 2021/03/06.
//

import Foundation

final class PhotoUploadModel: BaseModel {
  
  var name: String
  var id: Int
  var photo: Data
  
  init(name: String, id: Int, photo: Data) {
    self.name = name
    self.id = id
    self.photo = photo
  }
  
  struct Response: Decodable {
    let name: String
    let id: Int
    let photoName: String
  }
}
