//
//  NetworkManager.swift
//  cake-it
//
//  Created by seungbong on 2021/01/31.
//
/* 통신 담당 클래스
 * - 헤더 설정
 * - 캐시 처리
 */

import Foundation
import Alamofire
import SystemConfiguration

enum GETAPIError: Error {
  case test1
}

final class NetworkManager {

  static let shared = NetworkManager()
  
  init() { }
  
  func requestGet<T: Decodable>(api: NetworkCommon.API,
                                type: T.Type,
                                completion: @escaping (Result<T, GETAPIError>) -> Void) {
    guard let url = URL(string: api.urlString) else { return }
    let request = AF.request(url)
    self.request(request: request, type: T.self, completion: completion)
  }
  
  func requestPost<T: Decodable>(api: NetworkCommon.API,
                   type: T.Type,
                   param: BaseModel? = nil,
                   completion: @escaping (Result<T, GETAPIError>) -> Void) {
    guard let url = URL(string: api.urlString) else { return }
    let headers: HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
    let request = AF.request(url,
                             method: .post,
                             parameters: param,
                             encoder: JSONParameterEncoder.default,
                             headers: headers)
    self.request(request: request, type: T.self, completion: completion)
  }
  
  private func request<T: Decodable>(request: DataRequest,
                                     type: T.Type,
                                     completion: @escaping (Result<T, GETAPIError>) -> Void) {
    if !isInternetAvailable() {
      self.processError(message: "네트워크 연결을 확인해주세요.")
      return
    }
    
    self.networkingLog(request: request)
    request.responseJSON(completionHandler: { response in
      
      guard let data = response.data else {
        self.processError(message: "error type : data is nil")
        return
      }
      let result = response.result
      self.networkingLog(response: result)
      
      switch(result) {
      case .success(_):
        do {
          let decodedResponse = try JSONDecoder().decode(NetworkCommon.Response.self, from: data)
          if decodedResponse.status == 200 || decodedResponse.status == 201 {
            let decodedResponseDataForm = decodedResponse.data.data(using: .utf8)!
            let modelData = try JSONDecoder().decode(T.self, from: decodedResponseDataForm)
            completion(.success(modelData))
          } else {
            self.processError(message: "error : status code : \(String(describing: decodedResponse.status)), message: \(decodedResponse.message)")
            completion(.failure(.test1))
          }
        } catch {
          completion(.failure(.test1))
        }
      case .failure(let error):
        completion(.failure(.test1))
      }
    })
  }
  
  private func processError(message: String) {
    print("🔻 [Network Process Error] \n\t #file: \(#file), \n\t #function : \(#function) \n\t #line : \(#line) \n\t message : \(message)")
  }
  
  private func networkingLog(request: DataRequest) {
    print("💠 [Request Networking Log] Request Data \n: \(request)")
  }
  
  private func networkingLog(response: Any) {
    print("🌐 [Response Networking Log] Response Data \n: \(response)")
  }
}

/// Reachability
extension NetworkManager {
  /// 네트워크 연결 확인
  private func isInternetAvailable() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
        SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
      }
    }
    
    var flags = SCNetworkReachabilityFlags()
    
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
      return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    
    return (isReachable && !needsConnection)
  }
}
