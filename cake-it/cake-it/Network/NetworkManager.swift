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

class NetworkManager {
    
    static let shared = NetworkManager()
    
    init() { }
    

    func requestGet(api: NetworkCommon.Api, completion: @escaping () -> Void) {
        guard let url = URL(string: api.urlString) else { return }
        let request = AF.request(url)
        self.request(request: request, completion: completion)
    }
    
    
    func requestPost(api: NetworkCommon.Api, param: BaseModel? = nil, completion: @escaping () -> Void) {
        guard let url = URL(string: api.urlString) else { return }
        let headers: HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
        let request = AF.request(url,
                                 method: .post,
                                 parameters: param,
                                 encoder: JSONParameterEncoder.default,
                                 headers: headers)
        self.request(request: request, completion: completion)
    }
    
    private func request(request: DataRequest, completion: @escaping () -> Void) {
        request.responseJSON(completionHandler: { response in
            guard let data = response.data else {
                self.processError(message: "error type : data is nil")
                return
            }
            let result = response.result
            self.printNetworkLog(result: result)
            
            switch(result) {
            case .success(_):
                do {
                    let parsedResult = try JSONDecoder().decode(LoginModel.Response.self, from: data)
                    if parsedResult.status == 200 || parsedResult.status == 201 {
                        print("request Success!")
                        print(parsedResult)
                    } else {
                        self.processError(message: "error : status code : \(String(describing: parsedResult.status))")
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
    
    private func printNetworkLog(result: Any) {
        print("🌐 [Networking Log] response result : \(result)")
    }
}

