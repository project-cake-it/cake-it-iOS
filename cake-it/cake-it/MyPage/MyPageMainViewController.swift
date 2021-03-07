//
//  MyPageMainViewController.swift
//  cake-it
//
//  Created by Cory on 2021/02/16.
//

import UIKit

final class MyPageMainViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

// Test
extension MyPageMainViewController {
  @IBAction func getNicknameButtonDidTap(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Nickname", bundle: nil)
    let testVC = storyboard.instantiateViewController(identifier: "NicknameView")
    present(testVC, animated: true, completion: nil)
  }
  
  @IBAction func loginTestButtonDidTap(_ sender: Any) {
    let storyboard = UIStoryboard(name: "LoginTest", bundle: nil)
    let testLoginVC = storyboard.instantiateViewController(identifier: "LoginTestView")
    present(testLoginVC, animated: true, completion: nil)
  }
  
  @IBAction func photoUploadTestButtonDidTap(_ sender: Any) {
    let storyboard = UIStoryboard(name: "PhotoUpload", bundle: nil)
    let testPhotoVC = storyboard.instantiateViewController(identifier: "PhotoUploadView")
    present(testPhotoVC, animated: true, completion: nil)
  }
}
