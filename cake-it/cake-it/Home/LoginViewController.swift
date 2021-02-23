//
//  LoginViewController.swift
//  cake-it
//
//  Created by theodore on 2021/02/22.
//

import UIKit

final class LoginViewController: UIViewController {
  
  static let ID = "loginViewController"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func closeViewController(_ sender: Any) {
    //테스트용 메소드
    dismiss(animated: true, completion: nil)
  }
}
