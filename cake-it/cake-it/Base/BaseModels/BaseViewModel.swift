//
//  BaseViewModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import Foundation

class BaseViewModel: NSObject{
    
    // 에러 공통 처리
    func processingError(error: String) {
        print("🔻 [ViewModel Processing Error] \n\t #file: \(#file), \n\t #function : \(#function) \n\t #line : \(#line) \n\t Error: \(error)")
    }
}
