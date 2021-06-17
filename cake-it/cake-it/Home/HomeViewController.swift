//
//  HomeViewController.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit

final class HomeViewController: UIViewController {
  
  @IBOutlet weak var slideView: UIScrollView!
  @IBOutlet weak var themeCollectionView: UICollectionView!
  @IBOutlet weak var themeHideButton: UIButton!
  @IBOutlet weak var themeCollectionViewHeightConstraint: NSLayoutConstraint!
  
  let cakeDesignThemes: [CakeDesignTheme] = [.birthDay, .anniversary, .wedding, .promotion, .resignation, .discharge, .society, .etc]
  let themeCollecionViewHeightExpane: CGFloat = 228
  let themeCollecionViewHeightNomal: CGFloat = 108
  let themeListMinSize = 4
  
  var isThemeViewExpand: Bool = false {
    willSet {
      if (newValue) {
        themeHideButton.isHidden = false
        themeCollectionViewHeightConstraint.constant = themeCollecionViewHeightExpane
      } else {
        themeHideButton.isHidden = true
        themeCollectionViewHeightConstraint.constant = themeCollecionViewHeightNomal
      }
      themeCollectionView.reloadData()
    }
  }
  
  //MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configueSlideView()
    configueThemeCollectionView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//    checkLogin()
  }
  
  func configueSlideView() {
    //TODO: 테스트용 이미지
    let tempImageURL = "https://user-images.githubusercontent.com/24218456/122076633-01e0d600-ce36-11eb-9575-55305d4431aa.jpeg"
    let cakeImageURL = URL(string: tempImageURL)!
    let data = try? Data(contentsOf: cakeImageURL)
    let imageCount = 3
    
    for i in 0..<imageCount {
      let imageView = UIImageView()
      let xPos = self.view.frame.width * CGFloat(i)
      imageView.frame = CGRect(x: xPos,
                               y: 0,
                               width: self.view.frame.width,
                               height: self.view.frame.width)
      imageView.contentMode = .scaleAspectFill
      DispatchQueue.main.async {
        imageView.image = UIImage(data: data!)
      }
      slideView.addSubview(imageView)
    }
    
    slideView.contentSize.width = self.view.frame.width * CGFloat(imageCount)
    slideView.contentSize.height = self.view.frame.width
    slideView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
  }
  
  func configueThemeCollectionView() {
    themeCollectionView.delegate = self
    themeCollectionView.dataSource = self
    
    let identifier = String(describing: ThemeCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    themeCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
  }
  
  //MARK: - IBActions
  @IBAction func themeHideButtonDidTap(_ sender: Any) {
    isThemeViewExpand = false
  }
  
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
