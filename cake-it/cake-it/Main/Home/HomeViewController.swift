//
//  HomeViewController.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        networkTest()
    }
    
    private func networkTest() {
        loginNetworkTest()
        getNiknameNetworkTest()
    }
    
    
    private func loginNetworkTest() {
        let loginInfo = LoginModel(email: "seungbong8_8@naver.com", password: "Password1!")
        NetworkManager.shared.requestPost(api: .login, param: loginInfo, completion: { response in
            print("\n response data : \(response.data)")
        })
    }
    private func getNiknameNetworkTest() {
        NetworkManager.shared.requestGet(api: .randomNikname, completion: { response in
            print("\n response data : \(response.data)")
        })
    }
    
}
