//
//  AppDelegate.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  let KAKAO_APP_KEY = "336e5fa0e2a8c916ffda94b2b64f5c8d"
  let NAVER_CONSUMER_SECRET = "PFv_FX3EsN"
  let NAVER_CONSUMER_KEY = "N2SMwopXbdrTDABqVn1m"
  let GOOGLE_CLIENT_ID = "911891330500-qis1f628hh0oqdbnoj597cfgkgqnk9r4.apps.googleusercontent.com"
  let APP_NAME = "cakeit"
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    naverSDKInit()
    kakaoSDKInit()
    googleSignInSDKInit();
    
    return true
  }
  
  func application(_ application: UIApplication,
                   open url: URL,
                   options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if (AuthApi.isKakaoTalkLoginUrl(url)) {
      return AuthController.handleOpenUrl(url: url)
    }
    
    guard let naverConnection = NaverThirdPartyLoginConnection.getSharedInstance() else { return false }
    if (naverConnection.isNaverThirdPartyLoginAppschemeURL(url)) {
      return naverConnection.application(application, open: url, options: options)
    }
    
    guard let scheme = url.scheme else { return false }
    if scheme.contains("com.googleusercontent.apps") {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    return false
  }
  
  // MARK: - private method
  private func naverSDKInit() {
    let naverLogin = NaverThirdPartyLoginConnection.getSharedInstance()
    naverLogin?.isNaverAppOauthEnable = true
    naverLogin?.isInAppOauthEnable = true
    naverLogin?.isOnlyPortraitSupportedInIphone()
    naverLogin?.serviceUrlScheme = "cakeit"
    naverLogin?.consumerKey = NAVER_CONSUMER_KEY
    naverLogin?.consumerSecret = NAVER_CONSUMER_SECRET
    naverLogin?.appName = APP_NAME
  }
  
  private func kakaoSDKInit() {
    KakaoSDKCommon.initSDK(appKey: KAKAO_APP_KEY)
  }
  
  private func googleSignInSDKInit() {
    GIDSignIn.sharedInstance().clientID = GOOGLE_CLIENT_ID
  }
}

