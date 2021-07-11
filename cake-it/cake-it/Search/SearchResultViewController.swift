//
//  SearchResultViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/07/05.
//

import UIKit

final class SearchResultViewController: UIViewController {
  
  enum TappedTitleState {
    case design
    case shop
  }
  
  @IBOutlet weak var searchingWordLabel: UILabel!
  
  @IBOutlet weak var designTitleView: UIView!
  @IBOutlet weak var designTitleLabel: UILabel!
  @IBOutlet weak var shopTitleView: UIView!
  @IBOutlet weak var shopTitleLabel: UILabel!
  @IBOutlet weak var seperateView: UIView!
  @IBOutlet weak var seperateViewLeadingConstraint: NSLayoutConstraint!

  @IBOutlet weak var emptyResultView: UIView!
  @IBOutlet weak var designContainerView: UIView!
  @IBOutlet weak var shopContainerView: UIView!
  
  let DESIGN_TITLE_BUTTON_TAG = 100
  let SHOP_TITLE_BUTTON_TAG = 200
  
  var searcingText: String = ""
  var tappedTitleState: TappedTitleState = .design {
    didSet {
      updateView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  // MARK:- configuration
  private func configureView() {
    configureNavigationView()
    configureDesignListView()
    configureShopListView()
  }
 
  private func configureNavigationView() {
    searchingWordLabel?.text = searcingText
  }
  
  private func configureDesignListView() {
    let id = String(describing: DesignListViewController.self)
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    if let designVC = storyboard.instantiateViewController(withIdentifier: id) as? DesignListViewController {
      designVC.view.frame = designContainerView.frame
      designVC.hiddenNavigationView()
      designContainerView.addSubview(designVC.view)
      self.addChild(designVC)
    }
  }
  
  private func configureShopListView() {
    let id = String(describing: ShopsMainViewController.self)
    let storyboard = UIStoryboard(name: "Shops", bundle: nil)
    if let shopVC = storyboard.instantiateViewController(withIdentifier: id) as? ShopsMainViewController {
      shopVC.view.frame = shopContainerView.frame
      shopVC.hiddenTitleView()
      shopContainerView.addSubview(shopVC.view)
      self.addChild(shopVC)
    }
  }
    
  // MARK:- click event
  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func titleViewDidTap(_ sender: UIButton) {
    switch sender.tag {
    case DESIGN_TITLE_BUTTON_TAG:
      tappedTitleState = .design
    case SHOP_TITLE_BUTTON_TAG:
      tappedTitleState = .shop
    default: break
    }
  }
}


// MARK:- private func
extension SearchResultViewController {
  
  private func updateView() {
    updateTitleView()
    updateContainerView()
  }
  
  private func updateTitleView() {
    switch tappedTitleState {
    case .design:
      seperateViewLeadingConstraint.constant = 0.0
      designTitleLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
      designTitleLabel.textColor = Colors.pointB
      shopTitleLabel.font = Fonts.spoqaHanSans(weight: .Medium, size: 15)
      shopTitleLabel.textColor = Colors.black
      
    case .shop:
      seperateViewLeadingConstraint.constant = designTitleView.frame.width
      designTitleLabel.font = Fonts.spoqaHanSans(weight: .Medium, size: 15)
      designTitleLabel.textColor = Colors.black
      shopTitleLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
      shopTitleLabel.textColor = Colors.pointB
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  private func updateContainerView() {
    switch tappedTitleState {
    case .design:
      designContainerView.alpha = 1.0
      shopContainerView.alpha = 0.0
      if let childVC = findChildViewController(type: ShopsMainViewController.self) {
        let shopListVC = childVC as! ShopsMainViewController
        shopListVC.removeFilterDetailView()
      }
      
    case .shop:
      designContainerView.alpha = 0.0
      shopContainerView.alpha = 1.0
      if let childVC = findChildViewController(type: DesignListViewController.self) {
        let designListVC = childVC as! DesignListViewController
        designListVC.removeFilterDetailView()
      }
    }
  }
  
  private func findChildViewController(type: AnyClass) -> UIViewController? {
    for child in children {
      if child.isKind(of: type) {
        return child
      }
    }
    return nil
  }
}
