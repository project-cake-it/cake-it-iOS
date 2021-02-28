//
//  HomeViewController.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit

final class HomeViewController: UIViewController {
  //MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    checkLogin()
  }
}

//MARK: - Login
extension HomeViewController {
  private func checkLogin() {
    var loginToken: String? = "test"
    
    guard loginToken != nil else {
      return
    }
    
    if let loginViewController = storyboard?.instantiateViewController(identifier: LoginViewController.id) {
      loginViewController.modalPresentationStyle = .overFullScreen
      present(loginViewController, animated: false, completion: nil)
    }
  }
}
