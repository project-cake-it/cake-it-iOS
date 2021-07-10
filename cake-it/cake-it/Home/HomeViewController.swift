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
  
  private(set) var cakeDesigns: [CakeDesign] = []
  private let viewModel: HomeViewModel = HomeViewModel()
  
  let cakeDesignThemes: [FilterCommon.FilterTheme] = [.birthday, .anniversary, .wedding, .emplyment, .advancement, .leave, .discharge, .graduated, .christmas, .halloween, .newYear]
  let themeCollecionViewNomalHeight: CGFloat = 108
  let themesMinCount = 4
  
  let moreButtonIndex = 3
  
  var isThemeViewExpanded: Bool = false {
    willSet {
      if newValue {
        let height: CGFloat
        if cakeDesignThemes.count % 2 > 0 {
          height = (Metric.themeCellHeight + Metric.themeCollectionViewInterItemVerticalSpace) * CGFloat(cakeDesignThemes.count/2 + 1) - Metric.themeCollectionViewInterItemVerticalSpace
        } else {
          height = (Metric.themeCellHeight + Metric.themeCollectionViewInterItemVerticalSpace) * CGFloat(cakeDesignThemes.count/2) - Metric.themeCollectionViewInterItemVerticalSpace
        }
        
        themeHideButton.isHidden = false
        themeCollectionViewHeightConstraint.constant = height
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
    configureNavigationController()
    configureRankCollecionView()
    configueThemeCollectionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchPromotionImages()
    fetchRankCakeDesign()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //  checkLogin()
  }
  
  //MARK: - Private Func
  private func configueSlideView() {
    slideView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
  }
  
  private func configureNavigationController() {
    navigationController?.navigationBar.isHidden = true
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
    viewModel.requestBestCakeDesigns { success, result, error in
      if success {
        guard let result = result else { return }
        
        self.cakeDesigns = result
        self.rankCollectionView.reloadData()
        self.view.layoutIfNeeded()
        self.rankCollecionViewHeightConstraint.constant = self.rankCollectionView.contentSize.height
      }
    }
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
