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
  
  let naverLoginSDK = NaverThirdPartyLoginConnection.getSharedInstance()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: - Private method
  func closeLoginViewController() {
    dismiss(animated: true, completion: nil)
  }
  
  //MARK: - IBAction
  @IBAction func closeButtonForTestDidTap(_ sender: Any) {
    //테스트용 메소드
    closeLoginViewController()
  }
  
  @IBAction func signInWithKakaoButtonDidTap(_ sender: Any) {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
        if let error = error {
          print(error)
        } else {
          print("Login Success: %@", oauthToken!)
          self.closeLoginViewController()
        }
      }
    } else {
      UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
        if let error = error {
          print(error)
        } else {
          print("Login Success: %@", oauthToken!)
          self.closeLoginViewController()
        }
      }
    }
  }
  
  @IBAction func signInWithNaverButtonDidTap(_ sender: Any) {
    naverLoginSDK?.delegate = self
    naverLoginSDK?.requestThirdPartyLogin()
  }
}

extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    guard let isValidAccessToken = naverLoginSDK?.isValidAccessTokenExpireTimeNow() else { return }
    guard isValidAccessToken else { return }
    
    print(naverLoginSDK?.accessToken)
    closeLoginViewController()
  }
  
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    guard let isValidAccessToken = naverLoginSDK?.isValidAccessTokenExpireTimeNow() else { return }
    guard isValidAccessToken else { return }
    
    print(naverLoginSDK?.accessToken)
    closeLoginViewController()
  }
  
  func oauth20ConnectionDidFinishDeleteToken() {
    
  }
  
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
     
  }
}
