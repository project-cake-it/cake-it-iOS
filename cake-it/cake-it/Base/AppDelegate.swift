//
//  AppDelegate.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit

// kakao login
import KakaoSDKCommon
import KakaoSDKAuth

// naver Login
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  let KAKAO_APP_KEY = "336e5fa0e2a8c916ffda94b2b64f5c8d"
  let NAVER_CONSUMER_SECRET = "PFv_FX3EsN"
  let NAVER_CONSUMER_KEY = "N2SMwopXbdrTDABqVn1m"
  let APP_NAME = "cakeit"

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    naverSDKInit()
    kakaoSDKInit()
    
    return true
  }
  
  func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if (AuthApi.isKakaoTalkLoginUrl(url)) {
        return AuthController.handleOpenUrl(url: url)
    }
    
    guard let naverConnection = NaverThirdPartyLoginConnection.getSharedInstance() else {
      return false
    }
    
    if (naverConnection.isNaverThirdPartyLoginAppschemeURL(url)) {
      return naverConnection.application(application, open: url, options: options)
    }
    
    return false
  }

  // MARK: - private method
  func naverSDKInit() {
    let naverLogin = NaverThirdPartyLoginConnection.getSharedInstance()
    naverLogin?.isNaverAppOauthEnable = true
    naverLogin?.isInAppOauthEnable = true
    naverLogin?.isOnlyPortraitSupportedInIphone()
    naverLogin?.serviceUrlScheme = "cakeit"
    naverLogin?.consumerKey = NAVER_CONSUMER_KEY
    naverLogin?.consumerSecret = NAVER_CONSUMER_SECRET
    naverLogin?.appName = APP_NAME
  }
  
  func kakaoSDKInit() {
    KakaoSDKCommon.initSDK(appKey: KAKAO_APP_KEY)
  }
}

