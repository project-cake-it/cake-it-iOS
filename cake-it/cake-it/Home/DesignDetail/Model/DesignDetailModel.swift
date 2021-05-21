//
//  DeseignDetailModel.swift
//  cake-it
//
//  Created by seungbong on 2021/05/02.
//

import Foundation

struct DesignDetailModel {
  // 가게 정보
  let storeName: String     // 가게 이름
  let storeAddress: String  // 가게 주소
  var isSavedStore: Bool    // 가게 찜 여부
  
  // 케이크 디자인 정보
  let designName: String            // 케이크 디자인 이름
  let designImageUrlList: [String]  // 케이크 디자인 이미지 url 리스트
  let themeList: [String]           // 케이크 디자인 테마 리스트
  let priceBySize: [String: String] // 케이크 디자인 크기별 가격
  let kindOfCreamList: [String]     // 케이크 크림 종류
  let kindOfSheetList: [String]     // 케이크 시트 종류
}
