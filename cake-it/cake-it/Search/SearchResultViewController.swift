//
//  SearchResultViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/07/05.
//

import UIKit

final class SearchResultViewController: BaseViewController {
  
  enum TappedTitleType {
    case design
    case shop
  }
  
  enum TitleFontType {
    case normal
    case highlighted

    var font: UIFont {
      switch self {
      case .normal:       return Fonts.spoqaHanSans(weight: .Bold, size: 15)
      case .highlighted:  return Fonts.spoqaHanSans(weight: .Medium, size: 15)
      }
    }
    
    var textColor: UIColor {
      switch self {
      case .normal:       return Colors.black
      case .highlighted:  return Colors.primaryColor
      }
    }
  }

  @IBOutlet weak var keywordLabel: UILabel!
  
  @IBOutlet weak var designTitleView: UIView!
  @IBOutlet weak var designTitleLabel: UILabel!
  @IBOutlet weak var shopTitleView: UIView!
  @IBOutlet weak var shopTitleLabel: UILabel!
  @IBOutlet weak var seperateView: UIView!
  @IBOutlet weak var seperateViewLeadingConstraint: NSLayoutConstraint!

  @IBOutlet weak var designContainerView: UIView!
  @IBOutlet weak var shopContainerView: UIView!
  @IBOutlet weak var emptyResultView: UIView!
  
  private let DESIGN_TITLE_BUTTON_TAG = 100
  private let SHOP_TITLE_BUTTON_TAG = 200
  
  var keyword: String = ""
  var searchResult: SearchResult?
  private var currentTappedType: TappedTitleType = .design {
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
    configureContentView()
  }
 
  private func configureNavigationView() {
    keywordLabel?.text = keyword
  }
  
  private func configureContentView() {
    configureDesignListView()
    configureShopListView()
    
    // 최초 뷰 Configure 시 design 결과값이 없다면 shop 탭으로 이동
    if isEmptyResult(type: .design) {
      if isEmptyResult(type: .shop) {
        emptyResultView.isHidden = false
      } else {
        currentTappedType = .shop
      }
    }
  }
  
  private func configureDesignListView() {
    let id = String(describing: DesignListViewController.self)
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    if let designVC = storyboard.instantiateViewController(withIdentifier: id) as? DesignListViewController {
      designVC.view.frame = designContainerView.frame
      designVC.hideNavigationView()
      designVC.cakeDesigns = searchResult?.designs ?? []
      designContainerView.addSubview(designVC.view)
      self.addChild(designVC)
    }
  }
  
  private func configureShopListView() {
    let id = String(describing: ShopsMainViewController.self)
    let storyboard = UIStoryboard(name: "Shops", bundle: nil)
    if let shopVC = storyboard.instantiateViewController(withIdentifier: id) as? ShopsMainViewController {
      shopVC.view.frame = shopContainerView.frame
      shopVC.hideTitleView()
      shopVC.cakeShops = searchResult?.shops ?? []
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
      currentTappedType = .design
    case SHOP_TITLE_BUTTON_TAG:
      currentTappedType = .shop
    default: break
    }
  }
}


// MARK:- private function
extension SearchResultViewController {
  private func isEmptyResult(type: TappedTitleType) -> Bool {
    guard let result = searchResult else {
      return true
    }
    
    switch type {
    case .design:
      return result.designs.isEmpty
    case .shop:
      return result.shops.isEmpty
    }
  }
  
  private func updateView() {
    updateTitleView()
    updateContainerView()
  }
  
  private func updateTitleView() {
    switch currentTappedType {
    case .design:
      seperateViewLeadingConstraint.constant = 0.0
      designTitleLabel.font       = TitleFontType.highlighted.font
      designTitleLabel.textColor  = TitleFontType.highlighted.textColor
      shopTitleLabel.font         = TitleFontType.normal.font
      shopTitleLabel.textColor    = TitleFontType.normal.textColor
      
    case .shop:
      seperateViewLeadingConstraint.constant = designTitleView.frame.width
      designTitleLabel.font       = TitleFontType.normal.font
      designTitleLabel.textColor  = TitleFontType.normal.textColor
      shopTitleLabel.font         = TitleFontType.highlighted.font
      shopTitleLabel.textColor    = TitleFontType.highlighted.textColor
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  private func updateContainerView() {
    emptyResultView.isHidden = true
    if isEmptyResult(type: currentTappedType) {
      emptyResultView.isHidden = false
      return
    }
    
    switch currentTappedType {
    case .design:
      designContainerView.alpha = 1.0
      shopContainerView.alpha = 0.0
      if let childVC = childViewController(type: ShopsMainViewController.self) {
        let shopListVC = childVC as! ShopsMainViewController
        shopListVC.hideFilterDetailView()
      }
      
    case .shop:
      designContainerView.alpha = 0.0
      shopContainerView.alpha = 1.0
      if let childVC = childViewController(type: DesignListViewController.self) {
        let designListVC = childVC as! DesignListViewController
        designListVC.hideFilterDetailView()
      }
    }
  }
  
  private func childViewController(type: AnyClass) -> UIViewController? {
    for child in children {
      if child.isKind(of: type) {
        return child
      }
    }
    return nil
  }
}
