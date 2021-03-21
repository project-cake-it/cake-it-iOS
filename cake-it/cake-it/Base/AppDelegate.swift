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
    naverLogin?.consumerKey = "byuZm4RWfIdw5z1B8F_A"
    naverLogin?.consumerSecret = "uKONFKpBzl"
    naverLogin?.appName = "cakeit"
  }
  
  func kakaoSDKInit() {
    KakaoSDKCommon.initSDK(appKey: "6401b7f5ee32ca3b74931f6f8b76bfe6")
  }
}

