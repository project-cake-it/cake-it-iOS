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

enum APIError: Error {
  case InternetUnavailable
  case NetworkError
  case InvalidDataType
}

final class NetworkManager {
  
  static let shared = NetworkManager()
  
  init() { }
  
  func requestGet<T: Decodable>(api: NetworkCommon.API,
                                type: T.Type,
                                completion: @escaping (Result<T, APIError>) -> Void) {
    guard let url = URL(string: api.urlString) else { return }
    let request = AF.request(url)
    self.request(request: request, type: T.self, completion: completion)
  }
  
  func requestPost<T: Decodable>(api: NetworkCommon.API,
                                 type: T.Type,
                                 param: BaseModel? = nil,
                                 completion: @escaping (Result<T, APIError>) -> Void) {
    guard let url = URL(string: api.urlString) else { return }
    let headers: HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
    let request = AF.request(url,
                             method: .post,
                             parameters: param,
                             encoder: JSONParameterEncoder.default,
                             headers: headers)
    self.request(request: request, type: T.self, completion: completion)
  }
  
  
  func request<T: Decodable>(request: DataRequest,
                             type: T.Type,
                             completion: @escaping (Result<T, APIError>) -> Void) {
    if !isInternetAvailable() {
      completion(.failure(.InternetUnavailable))
      return
    }
    
    request.responseJSON { (response) in
      let result = response.result
      
      switch(result) {
      case .success(let responseData):
        do {
          let serializedData = try JSONSerialization.data(withJSONObject: responseData,
                                                          options: .prettyPrinted)
          let decodedResponse = try JSONDecoder().decode(NetworkCommon.Response<T>.self,
                                                         from: serializedData)
          print(decodedResponse)
          if decodedResponse.status == 200 || decodedResponse.status == 201 {
            completion(.success(decodedResponse.data))
          } else {
            completion(.failure(.NetworkError))
          }
        } catch {
          completion(.failure(.InvalidDataType))
        }
      case .failure(_):
        completion(.failure(.NetworkError))
      }
    }
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
