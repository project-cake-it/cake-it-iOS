//
//  DebuggingViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/10/18.
//

import UIKit

class DebuggingViewController: UIViewController {
  
  @IBOutlet var userTokenLabel: UILabel!
  @IBOutlet var responseLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userTokenLabel.text = LoginManager.shared.accessToken()
    
    let urlString = NetworkCommon.BASE_URL + "users"
    guard let url = URL(string: urlString) else { return }
    var request = URLRequest(url: url)
    request.addValue(LoginManager.shared.accessToken(), forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let resData = data else { return }
      let resString = String(data: resData, encoding: .utf8)
      DispatchQueue.main.async {
        self.responseLabel.text = resString
      }
    }.resume()
  }
}
