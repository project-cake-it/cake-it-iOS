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

enum LoginError: Error {
  case UserCancel
  case InvalidAccessToken
  case InvalidSocialType
}

final class LoginViewModel: BaseViewModel {
  
  typealias CommonCompletion = (Bool, Error?) -> Void
  
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
      loginCompletion?(false, error)
    } else {
      guard let accessToken = oauthToken?.accessToken else {
        loginCompletion?(false, LoginError.InvalidAccessToken)
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
      loginCompletion!(false, LoginError.InvalidSocialType)
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
          self.loginCompletion!(false, nil)
          return
        }
        
        self.loginCompletion!(true, nil)
      case .failure(let error):
        self.loginCompletion!(false, error)
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
      loginCompletion?(false, LoginError.InvalidAccessToken)
      return
    }
    
    self.requestLogin(accessToken: access)
  }
  
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    guard (naverLoginSDK?.isValidAccessTokenExpireTimeNow()) != nil else { return }
    
    guard let access = naverLoginSDK?.accessToken else {
      loginCompletion?(false, LoginError.InvalidAccessToken)
      return
    }
    
    self.requestLogin(accessToken: access)
  }
  
  func oauth20ConnectionDidFinishDeleteToken() {
    //TODO: logout 기능구현
  }
  
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    self.loginCompletion?(false, nil)
  }
}

//MARK: - Google Login
extension LoginViewModel: GIDSignInDelegate {
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if error != nil {
      loginCompletion?(false, LoginError.UserCancel)
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
        loginCompletion?(false, nil)
        return
      }
      
      guard let tokenString = String(data: jwtToken, encoding: .utf8) else {
        loginCompletion?(false, nil)
        return
      }
      
      self.requestLogin(accessToken: tokenString)
    default:
      loginCompletion?(false, nil)
    }
  }
  
  func authorizationController(controller: ASAuthorizationController,
                               didCompleteWithError error: Error) {
    guard let asError = error as? ASAuthorizationError else {
      loginCompletion?(false, nil)
      return
    }
    
    if asError.code == ASAuthorizationError.Code.canceled || asError.code == ASAuthorizationError.unknown {
      loginCompletion?(false, LoginError.UserCancel)
      return
    }
    
    loginCompletion?(false, error)
  }
}
