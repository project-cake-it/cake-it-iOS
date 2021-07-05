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
  
  @IBOutlet weak var testView: UIView!
  
  @IBOutlet weak var seperateViewLeadingConstraint: NSLayoutConstraint!
  
  let DESIGN_TITLE_BUTTON_TAG = 100
  let SHOP_TITLE_BUTTON_TAG = 200
  
  var searcingText: String = ""
  var tapState: ResultTapState = .design {
    didSet {
      moveSeperateView(complition: {
        self.updateTapLabel()
      })
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
  }
  
  private func configureView() {
    searchingTitle?.text = searcingText
    
    let designVC = DesignListViewController.instantiate(from: "Home")
    testView.addSubview(designVC.view)
  }
  
  private func moveSeperateView(complition: @escaping ()->Void) {
    
  }
  
  private func updateTapLabel() {
    if tapState == .design {
      designTitleLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
      designTitleLabel.textColor = Colors.pointB
      shopTitleLabel.font = Fonts.spoqaHanSans(weight: .Medium, size: 15)
      shopTitleLabel.textColor = Colors.black
    } else {
      designTitleLabel.font = Fonts.spoqaHanSans(weight: .Medium, size: 15)
      designTitleLabel.textColor = Colors.black
      shopTitleLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
      shopTitleLabel.textColor = Colors.pointB
    }
  }
  
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
