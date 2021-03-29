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
  
  private var model: LoginModel?
  
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
          guard let accessToken = oauthToken?.accessToken else { return }
          
          self.model = LoginModel(token: accessToken, type:"KAKAO")
          
          NetworkManager.shared.requestPost(api: .login,
                                            type: LoginModel.Response.self,
                                            param: self.model) { (response) in
            switch response {
            case .success(let result):
              let token = result.token
              
              self.closeLoginViewController()
            case .failure(let error):
              print(error)
              
              self.closeLoginViewController()
              break
            }
          }
          
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

    // 서버통신
    guard let access = naverLoginSDK?.accessToken else {
      return
    }
    
    model = LoginModel(token: access, type:"naver")
    
    NetworkManager.shared.requestPost(api: .login,
                                      type: LoginModel.Response.self,
                                      param: model) { (response) in
      switch response {
      case .success(let result):
        let token = result.token
        
        
        self.closeLoginViewController()
      case .failure(let error):
        
        self.closeLoginViewController()
        break
      }
    }
  }
  
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    guard let isValidAccessToken = naverLoginSDK?.isValidAccessTokenExpireTimeNow() else { return }
    guard isValidAccessToken else { return }
    
    print(naverLoginSDK?.accessToken)
    
    // 서버통신
    guard let access = naverLoginSDK?.accessToken else {
      return
    }
    
    model = LoginModel(token: access, type:"NAVER")
    
    NetworkManager.shared.requestPost(api: .login,
                                      type: LoginModel.Response.self,
                                      param: model) { (response) in
      switch response {
      case .success(let result):
        let token = result.token
        
      case .failure(let error):
        
        break
      }
    }
    
    //closeLoginViewController()
  }
  
  func oauth20ConnectionDidFinishDeleteToken() {
    
  }
  
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
     
  }
}
