//
//  AppDelegate.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit

// kakao login
import KakaoSDKCommon
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  let KAKAO_APP_KEY = "336e5fa0e2a8c916ffda94b2b64f5c8d"
  let NAVER_CONSUMER_SECRET = "PFv_FX3EsN"
  let NAVER_CONSUMER_KEY = "N2SMwopXbdrTDABqVn1m"
  let APP_NAME = "cakeit"

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    naverSDKInit()
    kakaoSDKInit()
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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

