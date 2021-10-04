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
  
  @IBOutlet var naverLoginButton: UIButton!
  @IBOutlet var kakaoLoginButton: UIButton!
  @IBOutlet var googleLoginButton: UIButton!
  @IBOutlet var appleLoginButton: UIButton!
  @IBOutlet var titleLabel: UILabel!
  
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
      self.closeLoginViewController()
      
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
      self.closeLoginViewController()
      
      delegate?.loginDidFinish(self, true)
    } else {
      guard let error = error else { return }
      
      if error as? LoginError == LoginError.UserCancel {
        // 구글로그인중 user cancel인 경우 alert을 띄우지 않는다.
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
      self.finishLogin(success: success)
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
    
    //Label
    let attributedString = NSMutableAttributedString(string: Constants.LOGIN_TITLE)
    attributedString.addAttribute(.foregroundColor, value: Colors.primaryColor, range: (Constants.LOGIN_TITLE as NSString).range(of: "달콤한"))
    titleLabel.attributedText = attributedString
  }
}
