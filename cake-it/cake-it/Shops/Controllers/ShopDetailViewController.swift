//
//  ShopDetailViewController.swift
//  cake-it
//
//  Created by Cory on 2021/05/08.
//

import UIKit

final class ShopDetailViewController: UIViewController {
  
  enum BottomInfoState {
    case cakeDesign
    case shopInfo
  }
  
  @IBOutlet weak var shopNameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var savedCountLabel: UILabel!
  @IBOutlet weak var showAvailableDateButton: UIButton!
  
  @IBOutlet weak var themeLabel: UILabel!
  @IBOutlet weak var priceInfoBySizeStackView: UIStackView!
  @IBOutlet weak var creamInfoLabel: UILabel!
  @IBOutlet weak var sheetInfoLabel: UILabel!
  
  @IBOutlet weak var cakeDesignButton: UIButton!
  @IBOutlet weak var shopInfoButton: UIButton!
  @IBOutlet weak var buttonIndexViewLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var buttonIndexViewTrailingConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomInfoCakeDesignView: UIView!
  @IBOutlet weak var bottomInfoShopInfoView: UIView!
  @IBOutlet weak var locationInfoContainerView: UIView!
  
  private var bottomInfoState: BottomInfoState = .cakeDesign {
    didSet {
      updateButtonInfoViewHiddenState()
      updateButtonState()
      updateBottomInfoButtonIndexView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    dismiss(animated: false, completion: nil)
  }
  
  @IBAction func cakeDesignButtonDidTap(_ sender: Any) {
    bottomInfoState = .cakeDesign
  }
  
  @IBAction func shopInfoButtonDidTap(_ sender: Any) {
    bottomInfoState = .shopInfo
  }
  
  @IBAction func copyAddressButtonDidTap(_ sender: Any) {
  }
  
  @IBAction func showMapButtonDidTap(_ sender: Any) {
  }
}

// MARK: - Update

extension ShopDetailViewController {
  private func updateButtonInfoViewHiddenState() {
    bottomInfoCakeDesignView.isHidden = bottomInfoState != .cakeDesign
    bottomInfoShopInfoView.isHidden = bottomInfoState != .shopInfo
    view.layoutIfNeeded()
  }
  
  private func updateButtonState() {
    if bottomInfoState == .cakeDesign {
      updateBottomInfoButton(cakeDesignButton)
      resetBottomInfoButton(shopInfoButton)
    } else {
      updateBottomInfoButton(shopInfoButton)
      resetBottomInfoButton(cakeDesignButton)
    }
  }
  
  private func updateBottomInfoButtonIndexView() {
    if bottomInfoState == .cakeDesign {
      buttonIndexViewLeadingConstraint.priority = .defaultHigh
      buttonIndexViewTrailingConstraint.priority = .defaultLow
    } else {
      buttonIndexViewLeadingConstraint.priority = .defaultLow
      buttonIndexViewTrailingConstraint.priority = .defaultHigh
    }
    UIView.animate(withDuration: 0.25,
                   delay: 0,
                   usingSpringWithDamping: 1.0,
                   initialSpringVelocity: 1.0,
                   options: .curveEaseOut) {
      self.view.layoutIfNeeded()
    }
  }
  
  private func updateBottomInfoButton(_ button: UIButton) {
    button.setTitleColor(Colors.pointB, for: .normal)
    button.titleLabel?.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
  }
  
  private func resetBottomInfoButton(_ button: UIButton) {
    button.setTitleColor(Colors.grayscale05, for: .normal)
    button.titleLabel?.font = Fonts.spoqaHanSans(weight: .Medium, size: 15)
  }
}

// MARK: - Configuration

extension ShopDetailViewController {
  private func configure() {
    configureViews()
  }
  
  private func configureViews() {
    showAvailableDateButton.layer.borderWidth = 1.0
    showAvailableDateButton.layer.borderColor = Colors.pointB.cgColor
    showAvailableDateButton.round(cornerRadius: 4.0, clipsToBounds: true)
    locationInfoContainerView.addBorder(borderColor: Colors.grayscale02, borderWidth: 1.0)
    bottomInfoShopInfoView.isHidden = true
    updateBottomInfoButton(cakeDesignButton)
    resetBottomInfoButton(shopInfoButton)
  }
}
