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
//        loginNetworkTest()
        getNiknameNetworkTest()
    }
    
    private func loginNetworkTest() {
        guard let url = URL(string: "http://13.124.173.58:8080/api/v2/login") else { return }
        let loginInfo = LoginModel(email: "seungbong8_8@naver.com", password: "Password1!")
        NetworkManager.shared.requestPost(url: url, param: loginInfo, completion: {})
    }
    private func getNiknameNetworkTest() {
        guard let url = URL(string: "http://13.124.173.58:8080/api/v2/nickname") else { return }
        NetworkManager.shared.requestGet(url: url, completion: {})
    }
    
}
