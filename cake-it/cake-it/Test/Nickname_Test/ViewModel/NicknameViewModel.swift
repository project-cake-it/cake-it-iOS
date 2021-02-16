//
//  NicknameViewModel.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import Foundation

class NicknameViewModel {
    
    var model: NicknameModel?
    
    init() {
        model = NicknameModel()
    }
    
    func performGetNickname(complition: @escaping (String) -> Void) {
        NetworkManager.shared.requestGet(api: .randomNikname, completion: { response in
            if let randName: String = response.data {
                let userNickname = "\(randName)\(self.model?.randNum ?? 0)"
                complition(userNickname)
            }
        })
    }
}
