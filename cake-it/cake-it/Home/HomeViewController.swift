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
    
    guard isLogin() else {
      if let loginViewController = storyboard?.instantiateViewController(identifier: LoginViewController.ID) {
        loginViewController.modalPresentationStyle = .overFullScreen
        present(loginViewController, animated: false, completion: nil)
      }
      return
    }
  }
}

//MARK: - Login
extension HomeViewController {
  
  private func isLogin() -> Bool {
    //TODO: Login 상태 체크
    return false
  }
}
