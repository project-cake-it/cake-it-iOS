//
//  LoginManager.swift
//  cake-it
//
//  Created by theodore on 2021/04/18.
//

import Foundation
import SwiftKeychainWrapper

final class LoginManager {
  static let shared = LoginManager()
  
  private let KEY_ACCESS_TOKEN = "accessToken"
  
  private init() {
  }
  
  func saveAccessToken(accessToken: String!) -> Bool {
    return KeychainWrapper.standard.set(accessToken, forKey: KEY_ACCESS_TOKEN)
  }
  
  func verifyAccessToken() -> Bool {
    //저장된 토큰이 사용가능한지 확인
    
    guard let accessToekn = KeychainWrapper.standard.string(forKey: KEY_ACCESS_TOKEN) else { return false }
    //TODO:서버 작업필요
    //Test를 위해서 토큰이 저장되면 verify가 된 것으로 설정
    return true
  }
  
  func refreshAccessToken() -> Bool {
    //만료된 토큰을 사용가능하도록 refresh 합니다.
    //리프레쉬가 실패한 경우 삭제처리를 해주어야 합니다.
    
    guard let accessToekn = KeychainWrapper.standard.string(forKey: KEY_ACCESS_TOKEN) else { return false }
    //TODO: 서버작업 필요
    return true
  }
  
  func resetAccessToken() {
    //서버 로그인을 완료한경우 저장된 토큰을 삭제합니다.
    KeychainWrapper.standard.removeObject(forKey: KEY_ACCESS_TOKEN)
  }
}
