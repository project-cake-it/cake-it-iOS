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

class NetworkManager {
    
    
    static let shared = NetworkManager()
    
    init() { }
    

    func requestGet(api: NetworkCommon.Api, completion: @escaping (NetworkCommon.Response) -> Void) {
        guard let url = URL(string: api.urlString) else { return }
        let request = AF.request(url)
        self.request(request: request, completion: completion)
    }
    
    
    func requestPost(api: NetworkCommon.Api, param: BaseModel? = nil, completion: @escaping (NetworkCommon.Response) -> Void) {
        guard let url = URL(string: api.urlString) else { return }
        let headers: HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
        let request = AF.request(url,
                                 method: .post,
                                 parameters: param,
                                 encoder: JSONParameterEncoder.default,
                                 headers: headers)
        self.request(request: request, completion: completion)
    }
    
    private func request(request: DataRequest, completion: @escaping (NetworkCommon.Response) -> Void) {
        
        // 네트워크 연결 확인
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
            self.printNetworkLogForResponse(responseData: result)
            
            switch(result) {
            case .success(_):
                do {
                    let parsedResult = try JSONDecoder().decode(NetworkCommon.Response.self, from: data)
                    if parsedResult.status == 200 || parsedResult.status == 201 {
                        completion(parsedResult)
                    } else {
                        self.processError(message: "error : status code : \(String(describing: parsedResult.status)), message: \(parsedResult.message)")
                    }
                } catch {
                    self.processError(message: "error type : parsing error")
                }
            case .failure(let error):
                self.processError(message: "error type: \(type(of: error))")
            }
        })
    }
    
    
    private func processError(message: String) {
        print("🔻 [Process Error] \(message)")
    }
    
    private func networkingLog(request: DataRequest) {
        print("💠 [Request Networking Log] Request Data \n: \(request)")
    }
    private func printNetworkLogForResponse(responseData: Any) {
        print("🌐 [Response Networking Log] Response Data \n: \(responseData)")
    }
    
}

/// Reachability
extension NetworkManager {
    
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
