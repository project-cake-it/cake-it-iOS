//
//  DesignDetailViewModel.swift
//  cake-it
//
//  Created by seungbong on 2021/05/02.
//

import Foundation

class DesignDetailViewModel {
  var designDetailModel: DesignDetailModel?
  
  init(storeName: String,
       storeAddress: String,
       isSaved: Bool,
       designName: String,
       iamgeUrls: [String],
       themes: [String],
       priceBySize: [String: String],
       kindOfCreams: [String],
       kindOfSheets: [String]) {
    
    designDetailModel = DesignDetailModel(storeName: storeName,
                                          storeAddress: storeAddress,
                                          isSavedStore: isSaved,
                                          designName: designName,
                                          designImageUrlList: iamgeUrls,
                                          themeList: themes,
                                          priceBySize: priceBySize,
                                          kindOfCreamList: kindOfCreams,
                                          kindOfSheetList: kindOfSheets)
  }
}
