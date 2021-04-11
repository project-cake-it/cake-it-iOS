//
//  LoginViewController.swift
//  cake-it
//
//  Created by theodore on 2021/02/22.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin

final class LoginViewController: UIViewController {
  
  static let id = "loginViewController"
  
  private var viewModel: LoginViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = LoginViewModel()
  }
  
  //MARK: - Private method
  func closeLoginViewController() {
    dismiss(animated: true, completion: nil)
  }
  
  //MARK: - IBAction
  @IBAction func closeButtonForTestDidTap(_ sender: Any) {
    closeLoginViewController()
  }
  
  @IBAction func signInWithKakaoButtonDidTap(_ sender: Any) {
    viewModel?.loginByProvider(socialType:.KAKAO, completion: { (Bool) in
      
    })
  }
  
  @IBAction func signInWithNaverButtonDidTap(_ sender: Any) {
    viewModel?.loginByProvider(socialType:.NAVER, completion: { (Bool) in
      
    })
  }
}
