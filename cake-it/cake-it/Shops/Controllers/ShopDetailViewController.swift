//
//  ShopDetailViewController.swift
//  cake-it
//
//  Created by Cory on 2021/05/08.
//

import UIKit

final class ShopDetailViewController: BaseViewController {
  
  enum BottomInfoState {
    case cakeDesign
    case shopInfo
  }
  
  enum Metric {
    static let cakeDesignsCollectionViewSidePadding: CGFloat = 0
    static let cakeDesignCellInterItemHorizontalSpace: CGFloat = 1.0
    static let cakeDesignCellInterItemVerticalSpace: CGFloat = 1.0
  }
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var shopNameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var savedCountLabel: UILabel!
  @IBOutlet weak var showAvailableDateButton: UIButton!
  
  @IBOutlet weak var themeLabel: UILabel!
  @IBOutlet weak var priceInfoBySizeStackView: UIStackView!
  @IBOutlet weak var creamInfoLabel: UILabel!
  @IBOutlet weak var sheetInfoLabel: UILabel!
  
  @IBOutlet weak var cakeDesignButton: UIButton!
  @IBOutlet weak var cakeDesignCollectionView: UICollectionView!
  @IBOutlet weak var cakeDesignCollectionViewHeight: NSLayoutConstraint!
  @IBOutlet weak var shopInfoButton: UIButton!
  @IBOutlet weak var buttonIndexViewLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var buttonIndexViewTrailingConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomInfoCakeDesignView: UIView!
  @IBOutlet weak var bottomInfoShopInfoView: UIView!
  @IBOutlet weak var locationInfoContainerView: UIView!
  @IBOutlet weak var contactShopButton: UIButton!
  @IBOutlet weak var contactShopButtonBottomConstraint: NSLayoutConstraint! {
    didSet {
      if !UIDevice.current.hasNotch {
        contactShopButtonBottomConstraint.constant =
          contactShopButtonBottomConstraint.constant - UIDevice.minimumBottomSpaceInNotchDevice
      }
    }
  }
  
  private var bottomInfoState: BottomInfoState = .cakeDesign {
    didSet {
      updateButtonInfoViewHiddenState()
      updateButtonState()
      updateBottomInfoButtonIndexView()
    }
  }
  
  private(set) var cakeDesigns: [CakeDesign] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    fetchDetailInfo()
    fetchCakeDesigns()
  }
  
  private func fetchDetailInfo() {
    updateCakeInfoSectionView()
  }
  
  private func fetchCakeDesigns() {
    let tempImageURL = "https://postfiles.pstatic.net/MjAyMTAzMjVfMjUw/MDAxNjE2Njg0MTc2OTc5.uKjj9xmaLrbGIbhnwiF7qhOroinNd60gbl8Jr6rMH18g.R7eRAZeHfGBv-wb8VZwo-r9IRqSLS-8Phocr7oiQ-g8g.PNG.cory_kim/Screen_Shot_2021-03-25_at_11.51.45_PM.png?type=w966"
    for _ in 0..<5 {
      cakeDesigns.append(CakeDesign(image: tempImageURL,
                                    location: "강남구",
                                    size: "1호 13cm",
                                    name: "화중이맛 케이크",
                                    price: 35000))
    }
    cakeDesignCollectionView.reloadData()
    view.layoutIfNeeded()
    cakeDesignCollectionViewHeight.constant = cakeDesignCollectionView.contentSize.height
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
  private func updateCakeInfoSectionView() {
    updateThemeInfo(themes: ["생일", "노랑", "축하", "연인", "졸업", "호중", "기념" ,"기타"])
    updatePriceInfoBySizeStackView(priceInfos: ["미니(12cm) / 15,000원", "1호(15cm) / 24,000원", "2호(18cm) / 32,000원"])
    updateCreamInfo(creams: ["오레오", "초코", "바닐라"])
    updateSheetInfo(sheets: ["오레오", "초코", "바닐라", "크림"])
  }
  
  private func updateThemeInfo(themes: [String]) {
    themeLabel.text = themes.map { "#" + $0 }.joined(separator: " ")
  }
  
  private func updatePriceInfoBySizeStackView(priceInfos: [String]) {
    priceInfos.forEach {
      let priceLabel = UILabel()
      priceLabel.text = $0
      priceLabel.font = Fonts.spoqaHanSans(weight: .Regular, size: 14)
      priceLabel.textColor = Colors.grayscale05
      priceLabel.translatesAutoresizingMaskIntoConstraints = false
      priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
      priceInfoBySizeStackView.addArrangedSubview(priceLabel)
    }
  }
  
  private func updateCreamInfo(creams: [String]) {
    creamInfoLabel.text = creams.joined(separator: ", ")
  }
  
  private func updateSheetInfo(sheets: [String]) {
    sheetInfoLabel.text = sheets.joined(separator: ", ")
  }
  
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
    configureCakeDesignCollectionView()
  }
  
  private func configureCakeDesignCollectionView() {
    cakeDesignCollectionView.dataSource = self
    cakeDesignCollectionView.delegate = self
  }
  
  private func configureViews() {
    showAvailableDateButton.layer.borderWidth = 1.0
    showAvailableDateButton.layer.borderColor = Colors.pointB.cgColor
    showAvailableDateButton.round(cornerRadius: 4.0, clipsToBounds: true)
    locationInfoContainerView.addBorder(borderColor: Colors.grayscale02, borderWidth: 1.0)
    bottomInfoShopInfoView.isHidden = true
    updateBottomInfoButton(cakeDesignButton)
    resetBottomInfoButton(shopInfoButton)
    contactShopButton.round(cornerRadius: 8.0)
  }
}
