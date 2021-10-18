//
//  LoginViewController.swift
//  cake-it
//
//  Created by theodore on 2021/02/22.
//

import UIKit

protocol LoginViewcontrollerDelegate : AnyObject {
  func loginDidFinish(_ viewController: LoginViewController, _ success: Bool)
}

final class LoginViewController: UIViewController {
  
  static let id = "loginViewController"
  let loginButtonRadius: CGFloat = 26
  
  @IBOutlet var backgroundImageView: UIImageView!
  @IBOutlet var naverLoginButton: UIButton!
  @IBOutlet var kakaoLoginButton: UIButton!
  @IBOutlet var googleLoginButton: UIButton!
  @IBOutlet var appleLoginButton: UIButton!
  
  private var viewModel: LoginViewModel?
  weak var delegate: LoginViewcontrollerDelegate?
  
  //MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = LoginViewModel(viewController: self)
    configureUI()
  }
  
  //MARK: - Private method
  private func closeLoginViewController() {
    dismiss(animated: true, completion: nil)
  }
  
  private func finishLogin(success: Bool) {
    if success {
      closeLoginViewController()
      delegate?.loginDidFinish(self, true)
    } else {
      let alert = UIAlertController(title: Constants.LOGIN_ALERT_FAIL_TITLE,
                                    message: Constants.LOGIN_ALERT_FAIL_MESSAGE,
                                    preferredStyle: .alert)
      let okAction = UIAlertAction(title: Constants.COMMON_ALERT_OK, style: .default, handler: nil)
      alert.addAction(okAction)
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  private func finishLogin(success: Bool, error: Error?) {
    if success {
      closeLoginViewController()
      delegate?.loginDidFinish(self, true)
    } else {
      if error as? LoginError == LoginError.UserCancel {
        // 로그인 중 user cancel인 경우 alert을 띄우지 않는다.
        return
      }
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
    viewModel?.login(by: .KAKAO, completion: { (success, error) in
      self.finishLogin(success: success, error: error)
    })
  }
  
  @IBAction func signInWithNaverButtonDidTap(_ sender: Any) {
    viewModel?.login(by: .NAVER, completion: { (success, error) in
      self.finishLogin(success: success)
    })
  }
  
  @IBAction func signInWithGoogleButtonDidTap(_ sender: Any) {
    viewModel?.login(by: .GOOGLE, completion: { (success, error) in
      self.finishLogin(success: success, error: error)
    })
  }
  
  @IBAction func signInWithAppleButtonDidTap(_ sender: Any) {
    viewModel?.login(by: .APPLE, completion: { success, error in
      self.finishLogin(success: success, error: error)
    })
  }
  
  //MARK: - configuration
  private func configureUI() {
    //Button
    naverLoginButton.layer.cornerRadius = loginButtonRadius
    kakaoLoginButton.layer.cornerRadius = loginButtonRadius
    googleLoginButton.layer.cornerRadius = loginButtonRadius
    appleLoginButton.layer.cornerRadius = loginButtonRadius
    
    googleLoginButton.layer.borderWidth = 1
    googleLoginButton.layer.borderColor = Colors.grayscale02.cgColor
    
    if let backgroundImage = LoginBackground.randomBackground() {
      backgroundImageView.image = backgroundImage
    }
  }
}