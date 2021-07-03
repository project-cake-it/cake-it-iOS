//
//  HomeViewController.swift
//  cake-it
//
//  Created by Cory Kim on 2021/01/23.
//

import UIKit
import Kingfisher

final class HomeViewController: UIViewController {
  
  enum Metric {
    static let rankCollectionViewSidePadding: CGFloat = 0
    static let cakeDesignCellInterItemHorizontalSpace: CGFloat = 1.0
    static let cakeDesignCellInterItemVerticalSpace: CGFloat = 4.0
    static let cakeDesignCellInfoAreaHeight: CGFloat = 120
    static let themeCellHeight: CGFloat = 48
    static let themeCollectionViewInterItemVerticalSpace: CGFloat = 12
    static let themeCollectionViewInterItemHorizontalSpace: CGFloat = 13
  }
  
  @IBOutlet weak var slideView: UIScrollView!
  
  @IBOutlet weak var themeCollectionView: UICollectionView!
  @IBOutlet weak var themeHideButton: UIButton!
  @IBOutlet weak var themeCollectionViewHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var rankCollectionView: UICollectionView!
  @IBOutlet weak var rankCollecionViewHeightConstraint: NSLayoutConstraint!
  
  private(set) var cakeDesigns: [CakeDesignForTest] = []
  private let viewModel: HomeViewModel = HomeViewModel()
  
  let cakeDesignThemes: [CakeDesignTheme] = [.birthDay, .anniversary, .wedding, .promotion, .resignation, .discharge, .society, .etc]
  let themeCollecionViewExpandHeight: CGFloat = 228
  let themeCollecionViewNomalHeight: CGFloat = 108
  let themesMinCount = 4
  
  let moreButtonIndex = 3
  
  var isThemeViewExpanded: Bool = false {
    willSet {
      if newValue {
        themeHideButton.isHidden = false
        themeCollectionViewHeightConstraint.constant = themeCollecionViewExpandHeight
      } else {
        themeHideButton.isHidden = true
        themeCollectionViewHeightConstraint.constant = themeCollecionViewNomalHeight
      }
      themeCollectionView.reloadData()
    }
  }
  
  //MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configueSlideView()
    fetchPromotionImages()
    
    configureRankCollecionView()
    fetchRankCakeDesign()
    
    configueThemeCollectionView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //  checkLogin()
  }
  
  //MARK: - Private Func
  private func configueSlideView() {
    slideView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
  }
  
  private func fetchPromotionImages() {
    viewModel.requestPromotionImage { success, result, error in
      if success {
        guard let result = result else { return }
        
        self.slideView.contentSize.width = self.view.frame.width * CGFloat(result.count)
        for i in 0..<result.count {
          let imageView = UIImageView()
          let xPos = self.view.frame.width * CGFloat(i)
          imageView.frame = CGRect(x: xPos,
                                   y: 0,
                                   width: self.view.frame.width,
                                   height: self.view.frame.width)
          imageView.contentMode = .scaleAspectFill
          imageView.kf.setImage(with: URL(string: result[i].imageUrl))
          self.slideView.addSubview(imageView)
        }
      } else {
        // set placeholder image
      }
    }
  }
  
  private func configureRankCollecionView() {
    rankCollectionView.delegate = self
    rankCollectionView.dataSource = self
    
    let identifier = String(describing: CakeDesignCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    rankCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
  }
  
  private func fetchRankCakeDesign() {
    let tempImageURL = "https://postfiles.pstatic.net/MjAyMTAzMjVfMjUw/MDAxNjE2Njg0MTc2OTc5.uKjj9xmaLrbGIbhnwiF7qhOroinNd60gbl8Jr6rMH18g.R7eRAZeHfGBv-wb8VZwo-r9IRqSLS-8Phocr7oiQ-g8g.PNG.cory_kim/Screen_Shot_2021-03-25_at_11.51.45_PM.png?type=w966"
    for _ in 0..<5 {
      cakeDesigns.append(CakeDesignForTest(image: tempImageURL,
                                           location: "강남구",
                                           size: "1호 13cm",
                                           name: "화중이맛 케이크",
                                           price: 35000))
    }
    
    rankCollectionView.reloadData()
    view.layoutIfNeeded()
    rankCollecionViewHeightConstraint.constant = rankCollectionView.contentSize.height
  }
  
  private func configueThemeCollectionView() {
    themeCollectionView.delegate = self
    themeCollectionView.dataSource = self
    
    let identifier = String(describing: HomeThemeCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    themeCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
  }
  
  //MARK: - IBActions
  @IBAction func themeHideButtonDidTap(_ sender: Any) {
    isThemeViewExpanded = false
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
