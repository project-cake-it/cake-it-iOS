//
//  LoginTestViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import UIKit

class LoginTestViewController: BaseViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var tokenLabel: UILabel!
    
    var viewModel: LoginTestViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = LoginTestViewModel()
   }
    
    @IBAction func clickedLoginButton(_ sender: Any) {
        if let userId = idTextField.text, let userPw = pwTextField.text {
            viewModel?.performLoginTest(email: userId, pw: userPw, complition: { loginToken in
                self.tokenLabel.text = loginToken
            })
        }
    }
}
