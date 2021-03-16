//
//  LoginTestViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import UIKit

final class LoginTestViewController: BaseViewController {
  
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var pwTextField: UITextField!
  @IBOutlet weak var tokenLabel: UILabel!
  
  private var viewModel: LoginTestViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = LoginTestViewModel()
  }
  
  @IBAction func loginButtonDidTap(_ sender: Any) {
    if let userID = idTextField.text, let userPW = pwTextField.text {
      viewModel?.performLoginTest(email: userID, password: userPW, completion: { loginToken in
        self.tokenLabel.text = loginToken
      })
    }
  }
}
