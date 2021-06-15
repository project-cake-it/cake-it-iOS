//
//  HomeViewController.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit

final class HomeViewController: UIViewController {
  //MARK: - Life cycle
  @IBOutlet weak var slideView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configSlideView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//    checkLogin()
  }
  
  func configSlideView() {
    let tempImageURL = "https://postfiles.pstatic.net/MjAyMTAzMjVfMjUw/MDAxNjE2Njg0MTc2OTc5.uKjj9xmaLrbGIbhnwiF7qhOroinNd60gbl8Jr6rMH18g.R7eRAZeHfGBv-wb8VZwo-r9IRqSLS-8Phocr7oiQ-g8g.PNG.cory_kim/Screen_Shot_2021-03-25_at_11.51.45_PM.png?type=w966"
    let cakeImageURL = URL(string: tempImageURL)!
    let data = try? Data(contentsOf: cakeImageURL)
    
    for i in 0..<3 {
      let imageView = UIImageView()
      let xPos = self.view.frame.width * CGFloat(i)
      imageView.frame = CGRect(x: xPos, y: 0, width: self.view.frame.width, height: self.view.frame.width)
      imageView.contentMode = .scaleAspectFill
      DispatchQueue.main.async {
        imageView.image = UIImage(data: data!)
      }
      slideView.addSubview(imageView)
    }
    slideView.contentSize.width = self.view.frame.width * CGFloat(3)
    slideView.contentSize.height = self.view.frame.width
  }
  
  
  @IBAction func toDesignListButtonDidTap(_ sender: Any) {
    let viewController = DesignListViewController.instantiate(from: "Home")
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: true)
  }
  
  //MARK: - IBActions
  @IBAction func testLogoutButtonDidTap(_ sender: Any) {
    LoginManager.shared.resetAccessToken()
    checkLogin()
  }
}

//MARK: - Login
extension HomeViewController {
  private func checkLogin() {
    if !LoginManager.shared.verifyAccessToken() {
      if let loginViewController = storyboard?.instantiateViewController(withIdentifier: LoginViewController.id) {
        loginViewController.modalPresentationStyle = .overFullScreen
        present(loginViewController, animated: false, completion: nil)
      }
    }
  }
}
