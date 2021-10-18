//
//  LoginViewController.swift
//  cake-it
//
//  Created by theodore on 2021/02/22.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
  func loginViewController(didFinishLogIn viewController: LoginViewController, _ success: Bool)
}

final class LoginViewController: UIViewController {
  
  static let id = "loginViewController"
  let loginButtonRadius: CGFloat = 26
  let numberOfImages = 11
  let imageTransitionTime: TimeInterval = 1.75
  let imageTransitionAnimationTime: TimeInterval = 0.75
  
  @IBOutlet var backgroundImageView: UIImageView!
  @IBOutlet var naverLoginButton: UIButton!
  @IBOutlet var kakaoLoginButton: UIButton!
  @IBOutlet var googleLoginButton: UIButton!
  @IBOutlet var appleLoginButton: UIButton!
  
  private var viewModel: LoginViewModel?
  weak var delegate: LoginViewControllerDelegate?
  
  private var shuffledIndex: [Int] = []
  private var currentImageIndex = 0
  private var timer: Timer!
  
  //MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = LoginViewModel(viewController: self)
    configure()
  }
  
  deinit {
    timer = nil
  }
  
  //MARK: - Private method
  private func closeLoginViewController() {
    dismiss(animated: true, completion: nil)
  }
  
  private func finishLogin(success: Bool) {
    if success {
      closeLoginViewController()
      delegate?.loginViewController(didFinishLogIn: self, true)
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
      delegate?.loginViewController(didFinishLogIn: self, true)
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
}

// MARK: - Configuration

extension LoginViewController {
  private func configure() {
    configureUI()
    configureIndexes()
    configureBackgroundImage()
    configureTimer()
  }
  
  private func configureUI() {
    naverLoginButton.layer.cornerRadius = loginButtonRadius
    kakaoLoginButton.layer.cornerRadius = loginButtonRadius
    googleLoginButton.layer.cornerRadius = loginButtonRadius
    appleLoginButton.layer.cornerRadius = loginButtonRadius
    googleLoginButton.layer.borderWidth = 1
    googleLoginButton.layer.borderColor = Colors.grayscale02.cgColor
  }
  
  private func configureIndexes() {
    var indexes: [Int] = []
    for i in 0..<numberOfImages { indexes.append(i) }
    shuffledIndex = indexes.shuffled()
  }
  
  private func configureBackgroundImage() {
    let index = shuffledIndex[currentImageIndex]
    backgroundImageView.image = cakeImage(by: index)
  }
  
  private func configureTimer() {
    timer = Timer.scheduledTimer(
      timeInterval: imageTransitionTime,
      target: self,
      selector: #selector(changeImage),
      userInfo: nil,
      repeats: true)
    RunLoop.main.add(timer, forMode: .common)
  }
  
  @objc private func changeImage() {
    currentImageIndex += 1
    if currentImageIndex >= numberOfImages  { currentImageIndex = 0 }
    let index = shuffledIndex[currentImageIndex]
    UIView.transition(with: self.backgroundImageView,
                      duration: imageTransitionAnimationTime,
                      options: .transitionCrossDissolve,
                      animations: { [weak self] in
                        self?.backgroundImageView.image = self?.cakeImage(by: index)
                      })
  }
  
  private func cakeImage(by index: Int) -> UIImage? {
    let strIndex = String(format: "%02d", index + 1)
    let imageName = "loginBackground\(strIndex)"
    return UIImage(named: imageName)
  }
}
