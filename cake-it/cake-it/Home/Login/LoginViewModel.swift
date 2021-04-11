//
//  LoginViewModel.swift
//  cake-it
//
//  Created by theodore on 2021/04/01.
//

import Foundation
import KakaoSDKUser
import NaverThirdPartyLogin

typealias CommonCompletionHandler = (Bool) -> Void

final class LoginViewModel: BaseViewModel {
  
  private var model: LoginModel?
  private var socialType: SocialType?
  private var completionHandler: CommonCompletionHandler?
  private let naverLoginSDK = NaverThirdPartyLoginConnection.getSharedInstance()
  
  func loginByProvider(socialType: SocialType, completion: @escaping CommonCompletionHandler) {
    completionHandler = completion
    self.socialType = socialType
    
    switch socialType {
    case .KAKAO:
      signInWithKakaoWithCompletion()
    case .NAVER:
      signInWithNaverWithCompletionHandler()
    default:
      // 에러처리
      signInWithKakaoWithCompletion()
    }
  }
  
  func signInWithKakaoWithCompletion() {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
        if let error = error {
          guard let completionHandler = self.completionHandler else { return }
          completionHandler(false)
        } else {
          guard let accessToken = oauthToken?.accessToken else {
            self.completionHandler!(false)
            return
          }
          guard let refreshToken = oauthToken?.accessToken else {
            self.completionHandler!(false)
            return
          }
          
          self.login(accessToekn: accessToken, refreshToekn: refreshToken)
        }
      }
      
      return
    }
    
    UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
      if let error = error {
        guard let completionHandler = self.completionHandler else { return }
        completionHandler(false)
      } else {
        guard let accessToken = oauthToken?.accessToken else {
          self.completionHandler!(false)
          return
        }
        guard let refreshToken = oauthToken?.accessToken else {
          self.completionHandler!(false)
          return
        }
        
        self.login(accessToekn: accessToken, refreshToekn: refreshToken)
      }
    }
  }
  
  func signInWithNaverWithCompletionHandler() {
    //self.naverLoginSDK?.delegate = self
    self.naverLoginSDK?.requestThirdPartyLogin()
  }
  
  func login(accessToekn: String, refreshToekn:String) {
    
    guard let socialType = socialType?.rawValue else {
      self.completionHandler!(false)
      return
    }
    
    model = LoginModel(accessToken: accessToekn, type:socialType)
    
    NetworkManager.shared.requestPost(api: .login,
                                      type: LoginModel.Response.self,
                                      param: model) { (response) in
      switch response {
      case .success(let result):
        let token = result.accessToken
        // TODO: AccessToken 저장
        self.completionHandler!(true)
      case .failure(let error):
        print(error)
        self.completionHandler!(false)
        break
      }
    }
  }
}

//extension LoginViewModel: NaverThirdPartyLoginConnectionDelegate {
//
//  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
//    guard let isValidAccessToken = naverLoginSDK?.isValidAccessTokenExpireTimeNow() else { return }
//
//    // 서버통신
//    guard let access = naverLoginSDK?.accessToken else {
//      return
//    }
//
//    model = LoginRequestModel(token: access, type:"naver")
//
//    NetworkManager.shared.requestPost(api: .login,
//                                      type: LoginRequestModel.Response.self,
//                                      param: model) { (response) in
//      switch response {
//      case .success(let result):
//        let token = result.token
//
//
//      case .failure(let error):
//
//        break
//      }
//    }
//  }
//
//  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
//    guard let isValidAccessToken = naverLoginSDK?.isValidAccessTokenExpireTimeNow() else { return }
//    guard isValidAccessToken else { return }
//
//    print(naverLoginSDK?.accessToken)
//
//    // 서버통신
//    guard let access = naverLoginSDK?.accessToken else {
//      return
//    }
//
//    model = LoginRequestModel(token: access, type:"NAVER")
//
//    NetworkManager.shared.requestPost(api: .login,
//                                      type: LoginRequestModel.Response.self,
//                                      param: model) { (response) in
//      switch response {
//      case .success(let result):
//        let token = result.token
//
//      case .failure(let error):
//
//        break
//      }
//    }
//
//  }
//
//  func oauth20ConnectionDidFinishDeleteToken() {
//
//  }
//
//  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
//
//  }
//}
