//
//  LoginViewModel.swift
//  cake-it
//
//  Created by theodore on 2021/04/01.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth
import NaverThirdPartyLogin


final class LoginViewModel: BaseViewModel {
  
  typealias CommonCompletionHandler = (Bool) -> Void
  
  private var model: LoginModel?
  private var socialType: LoginSocialType?
  private var completionHandler: CommonCompletionHandler?
  private let naverLoginSDK = NaverThirdPartyLoginConnection.getSharedInstance()
  
  func loginByProvider(socialType: LoginSocialType, completion: @escaping CommonCompletionHandler) {
    completionHandler = completion
    naverLoginSDK?.delegate = self
    self.socialType = socialType
    
    switch socialType {
    case .KAKAO:
      signInWithKakaoWithCompletion()
    case .NAVER:
      signInWithNaverWithCompletionHandler()
    default:
      completion(false)
    }
  }
  
  func signInWithKakaoWithCompletion() {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
        self.processKakaoLoginRespone(oauthToken: oauthToken, error: error)
        return
      }
    }
    
    UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
      self.processKakaoLoginRespone(oauthToken: oauthToken, error: error)
    }
  }
  
  private func processKakaoLoginRespone(oauthToken: OAuthToken?, error: Error?) {
    if let error = error {
      print(error)
      self.completionHandler?(false)
    } else {
      guard let accessToken = oauthToken?.accessToken else {
        self.completionHandler?(false)
        return
      }
      guard let refreshToken = oauthToken?.accessToken else {
        self.completionHandler?(false)
        return
      }
      
      self.login(accessToekn: accessToken, refreshToken: refreshToken)
    }
  }
  
  func signInWithNaverWithCompletionHandler() {
    //self.naverLoginSDK?.delegate = self
    self.naverLoginSDK?.requestThirdPartyLogin()
  }
  
  func login(accessToken: String, refreshToken:String) {
    guard let socialType = socialType?.string else {
      self.completionHandler?(false)
      return
    }
    
    model = LoginModel(accessToken: accessToken, type:socialType)
    
    NetworkManager.shared.requestPost(api: .login,
                                      type: LoginModel.Response.self,
                                      param: model) { (response) in
      
      //TODO: 무조건 성공 login success test
      guard LoginManager.shared.saveAccessToken(accessToken: "~~~~~~~testToken~~~~~~`") else {
        self.completionHandler?(false)
        return
      }
      
      self.completionHandler?(true)
      return
      // login success test
      
      switch response {
      case .success(let result):
        let token = result.accessToken
        
        guard LoginManager.shared.saveAccessToken(accessToken: token) else {
          self.completionHandler!(false)
          return
        }
        
        self.completionHandler!(true)
      case .failure(let error):
        print(error)
        self.completionHandler!(false)
        break
      }
    }
  }
}

extension LoginViewModel: NaverThirdPartyLoginConnectionDelegate {
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    guard (naverLoginSDK?.isValidAccessTokenExpireTimeNow()) != nil else { return }

    // 서버통신
    guard let access = naverLoginSDK?.accessToken else {
      self.completionHandler?(false)
      return
    }
    
    guard let refresh = naverLoginSDK?.refreshToken else {
      self.completionHandler?(false)
      return
    }
    
    self.login(accessToken: access, refreshToken: refresh)
  }

  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    guard (naverLoginSDK?.isValidAccessTokenExpireTimeNow()) != nil else { return }

    // 서버통신
    guard let access = naverLoginSDK?.accessToken else {
      self.completionHandler?(false)
      return
    }
    
    guard let refresh = naverLoginSDK?.refreshToken else {
      self.completionHandler?(false)
      return
    }
    
    self.login(accessToken: access, refreshToken: refresh)
  }

  func oauth20ConnectionDidFinishDeleteToken() {
    //TODO: logout 기능구현
  }

  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    //TODO: logout 기능구현
  }
}
