//
//  HomeViewController.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}


// Network Test
extension HomeViewController {
    
    @IBAction func clickedTestButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Nickname", bundle: nil)
        let testVC = storyboard.instantiateViewController(identifier: "NicknameView")
        present(testVC, animated: true, completion: nil)
    }
    
    @IBAction func clickedLoginTestButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginTest", bundle: nil)
        let testLoginVC = storyboard.instantiateViewController(identifier: "LoginTestView")
        present(testLoginVC, animated: true, completion: nil)
    }
}
