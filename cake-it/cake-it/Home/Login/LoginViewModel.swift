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
import GoogleSignIn
import AuthenticationServices

final class LoginViewModel: BaseViewModel {
  
  typealias CommonCompletion = (Bool) -> Void
  
  private var model: LoginModel?
  private var socialType: LoginSocialType?
  private var loginCompletion: CommonCompletion?
  private let naverLoginSDK = NaverThirdPartyLoginConnection.getSharedInstance()
  private let viewController: UIViewController
  
  init(viewController: UIViewController) {
    self.viewController = viewController
    super.init()
    naverLoginSDK?.delegate = self
    GIDSignIn.sharedInstance().delegate = self
  }
  
  func login(by socialType: LoginSocialType,
             completion: @escaping CommonCompletion) {
    loginCompletion = completion
    self.socialType = socialType
    
    switch socialType {
    case .KAKAO:
      signInKakao()
      break
    case .NAVER:
      signInNaver()
      break
    case .GOOGLE:
      signInGoogle(viewController: viewController)
      break
    case .APPLE:
      signInApple()
      break
    }
  }
  
  private func signInApple() {
    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }

  private func signInKakao() {
    if UserApi.isKakaoTalkLoginAvailable() {
      UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
        self.processKakaoLoginRespone(oauthToken: oauthToken, error: error)
      }
      return
    }
    
    UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
      self.processKakaoLoginRespone(oauthToken: oauthToken, error: error)
    }
    return
  }
  
  private func processKakaoLoginRespone(oauthToken: OAuthToken?, error: Error?) {
    if let error = error {
      print(error)
      loginCompletion?(false)
    } else {
      guard let accessToken = oauthToken?.accessToken else {
        loginCompletion?(false)
        return
      }
      
      self.requestLogin(accessToken: accessToken)
    }
  }
  
  private func signInGoogle(viewController: UIViewController) {
    GIDSignIn.sharedInstance().presentingViewController = viewController
    GIDSignIn.sharedInstance().signIn()
  }
  
  private func signInNaver() {
    self.naverLoginSDK?.requestThirdPartyLogin()
  }
  
  private func requestLogin(accessToken: String) {
    guard let socialType = self.socialType else {
      loginCompletion!(false)
      return
    }
    
    let socialTypeString = String(describing: socialType.rawValue)
    model = LoginModel(accessToken: accessToken, type:socialTypeString)
    
    NetworkManager.shared.requestPost(api: .login,
                                      type: LoginModel.Response.self,
                                      param: model) { (result) in
      switch result {
      case .success(let result):
        let token = result.accessToken
        
        guard LoginManager.shared.saveAccessToken(accessToken: token) else {
          self.loginCompletion!(false)
          return
        }
        
        self.loginCompletion!(true)
      case .failure(_):
        self.loginCompletion!(false)
        break
      }
    }
  }
}

//MARK: - Naver Login
extension LoginViewModel: NaverThirdPartyLoginConnectionDelegate {
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    guard (naverLoginSDK?.isValidAccessTokenExpireTimeNow()) != nil else { return }
    
    guard let access = naverLoginSDK?.accessToken else {
      loginCompletion?(false)
      return
    }
    
    self.requestLogin(accessToken: access)
  }
  
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    guard (naverLoginSDK?.isValidAccessTokenExpireTimeNow()) != nil else { return }
    
    guard let access = naverLoginSDK?.accessToken else {
      loginCompletion?(false)
      return
    }
    
    self.requestLogin(accessToken: access)
  }
  
  func oauth20ConnectionDidFinishDeleteToken() {
    //TODO: logout 기능구현
  }
  
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    self.loginCompletion?(false)
  }
}

//MARK: - Google Login
extension LoginViewModel: GIDSignInDelegate {
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if error != nil {
      loginCompletion?(false)
      return
    }
    
    requestLogin(accessToken: user.authentication.accessToken)
  }
}

//MARK: - Apple Login
extension LoginViewModel: ASAuthorizationControllerDelegate,
                          ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return viewController.view.window!
  }
  
  func authorizationController(controller: ASAuthorizationController,
                               didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
    case let appleIdCredential as ASAuthorizationAppleIDCredential:
      guard let jwtToken = appleIdCredential.identityToken else {
        loginCompletion?(false)
        return
      }
      
      guard let tokenString = String(data: jwtToken, encoding: .utf8) else {
        loginCompletion?(false)
        return
      }
      
      self.requestLogin(accessToken: tokenString)
    default:
      loginCompletion?(false)
    }
  }
  
  func authorizationController(controller: ASAuthorizationController,
                               didCompleteWithError error: Error) {
    loginCompletion?(false)
  }
}
