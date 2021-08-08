//
//  LoginViewController.swift
//  cake-it
//
//  Created by theodore on 2021/02/22.
//

import UIKit

final class LoginViewController: UIViewController {
  
  static let id = "loginViewController"
  
  private var viewModel: LoginViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = LoginViewModel(viewController: self)
  }
  
  //MARK: - Private method
  private func closeLoginViewController() {
    dismiss(animated: true, completion: nil)
  }
  
  private func finishLogin(success: Bool) {
    if success {
      self.closeLoginViewController()
    } else {
      let alert = UIAlertController(title: Constants.LOGIN_ALERT_FAIL_TITLE,
                                    message: Constants.LOGIN_ALERT_FAIL_MESSAGE,
                                    preferredStyle: .alert)
      let okAction = UIAlertAction(title: Constants.COMMON_ALERT_OK, style: .default, handler: nil)
      alert.addAction(okAction)
      self.present(alert, animated: false, completion: nil)
    }
  }
  
  //MARK: - IBAction
  @IBAction func closeButtonForTestDidTap(_ sender: Any) {
    closeLoginViewController()
  }
  
  @IBAction func signInWithKakaoButtonDidTap(_ sender: Any) {
    viewModel?.login(by: .KAKAO, completion: { (success) in
      self.finishLogin(success: success)
    })
  }
  
  @IBAction func signInWithNaverButtonDidTap(_ sender: Any) {
    viewModel?.login(by: .NAVER, completion: { (success) in
      self.finishLogin(success: success)
    })
  }
  
  @IBAction func signInWithGoogleButtonDidTap(_ sender: Any) {
    viewModel?.login(by: .GOOGLE, completion: { (success) in
      self.finishLogin(success: success)
    })
  }
  
  @IBAction func signInWithAppleButtonDidTap(_ sender: Any) {
    viewModel?.login(by: .APPLE, completion: { success in
      self.finishLogin(success: success)
    })
  }
}
