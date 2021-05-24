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
//    checkLogin()
  }
  
  @IBAction func toDesignListButtonDidTap(_ sender: Any) {
    let viewController = DesignListViewController.instantiate(from: "Home")
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: true)
  }
  
  //MARK: - IBActions
  @IBAction func testLogoutButtonDidTap(_ sender: Any) {
    LoginManager.shared.resetAccessToken()
    checkLogin()
  }
}

//MARK: - Login
extension HomeViewController {
  private func checkLogin() {
    if !LoginManager.shared.verifyAccessToken() {
      if let loginViewController = storyboard?.instantiateViewController(withIdentifier: LoginViewController.id) {
        loginViewController.modalPresentationStyle = .overFullScreen
        present(loginViewController, animated: false, completion: nil)
      }
    }
  }
}
