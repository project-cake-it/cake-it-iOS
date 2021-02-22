//
//  HomeViewController.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit

class HomeViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    //TODO: login token check
    var loginToken: String?
    
    if let token = loginToken {
      NSLog("HomeViewController token check : %@", token)
    } else {
      let loginViewController = self.storyboard?.instantiateViewController(identifier: "loginViewController") as! UIViewController
      loginViewController.modalPresentationStyle = .overFullScreen
      self.present(loginViewController, animated: false, completion: nil)
    }
  }
}
