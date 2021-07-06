//
//  SearchResultViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/07/05.
//

import UIKit

final class SearchResultViewController: UIViewController {
  
  enum ResultTapState {
    case design
    case shop
  }
  
  @IBOutlet weak var searchingTitle: UILabel!
  
  @IBOutlet weak var designTitleView: UIView!
  @IBOutlet weak var shopTitleView: UIView!
  @IBOutlet weak var designTitleLabel: UILabel!
  @IBOutlet weak var shopTitleLabel: UILabel!
  @IBOutlet weak var seperateView: UIView!

  @IBOutlet weak var designContainerView: UIView!
  @IBOutlet weak var shopContainerView: UIView!
  @IBOutlet weak var containerViewLeadingConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var seperateViewLeadingConstraint: NSLayoutConstraint!
  
  let DESIGN_TITLE_BUTTON_TAG = 100
  let SHOP_TITLE_BUTTON_TAG = 200
  
  var searcingText: String = ""
  var tapState: ResultTapState = .design {
    didSet {
      moveView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
  }
  
  // MARK:- configure View
  private func configureView() {
    configureNavigationView()
    configureDesignListView()
    configureShopListView()
  }
  
  private func configureNavigationView() {
    searchingTitle?.text = searcingText
  }
  
  private func configureDesignListView() {
    let id = String(describing: DesignListViewController.self)
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    if let designVC = storyboard.instantiateViewController(withIdentifier: id) as? DesignListViewController {
      designVC.view.frame = designContainerView.frame
      designContainerView.addSubview(designVC.view)
      self.addChild(designVC)
    }
  }
  
  private func configureShopListView() {
    let id = String(describing: ShopsMainViewController.self)
    let storyboard = UIStoryboard(name: "Shops", bundle: nil)
    if let shopVC = storyboard.instantiateViewController(withIdentifier: id) as? ShopsMainViewController {
      shopVC.view.frame = shopContainerView.frame
      shopContainerView.addSubview(shopVC.view)
      self.addChild(shopVC)
    }
  }
    
  // MARK:- click event
  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func TapTitleViewDidTap(_ sender: UIButton) {
    switch sender.tag {
    case DESIGN_TITLE_BUTTON_TAG:
      tapState = .design
    case SHOP_TITLE_BUTTON_TAG:
      tapState = .shop
    default: break
    }
  }
}


// MARK:- private func
extension SearchResultViewController {
  
  private func moveView() {
    switch tapState {
    case .design:
      containerViewLeadingConstraint.constant = 0.0
      seperateViewLeadingConstraint.constant = 0.0
      designTitleLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
      designTitleLabel.textColor = Colors.pointB
      shopTitleLabel.font = Fonts.spoqaHanSans(weight: .Medium, size: 15)
      shopTitleLabel.textColor = Colors.black
    case .shop:
      containerViewLeadingConstraint.constant = -Constants.SCREEN_WIDTH
      seperateViewLeadingConstraint.constant = designTitleView.frame.width
      designTitleLabel.font = Fonts.spoqaHanSans(weight: .Medium, size: 15)
      designTitleLabel.textColor = Colors.black
      shopTitleLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
      shopTitleLabel.textColor = Colors.pointB
    }
    
    UIView.animate(withDuration: 0.5, animations: {
      self.view.layoutIfNeeded()
    })
  }
}
