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
    static let contactShopButtonBottomSpaceDefault: CGFloat = -16
    static let contactShopButtonBottomSpaceHidden: CGFloat = 200
  }
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var shopNameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var savedButton: UIButton!
  @IBOutlet weak var savedCountLabel: UILabel!
  @IBOutlet weak var showAvailableDateButton: UIButton!
  
  @IBOutlet weak var themeLabel: UILabel!
  @IBOutlet weak var priceInfoBySizeStackView: UIStackView!
  @IBOutlet weak var creamInfoLabel: UILabel!
  @IBOutlet weak var sheetInfoLabel: UILabel!
  
  @IBOutlet weak var shopInformationLabel: UILabel!
  @IBOutlet weak var openingTimeLabel: UILabel!
  @IBOutlet weak var pickUpAvailableTimeLabel: UILabel!
  @IBOutlet weak var holidayLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  
  @IBOutlet weak var cakeDesignButton: UIButton!
  @IBOutlet weak var cakeDesignCollectionView: UICollectionView!
  @IBOutlet weak var cakeDesignCollectionViewHeight: NSLayoutConstraint!
  @IBOutlet weak var shopInfoButton: UIButton!
  @IBOutlet weak var buttonIndexViewLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var buttonIndexViewTrailingConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomInfoCakeDesignView: UIView!
  @IBOutlet weak var bottomInfoShopInfoView: UIView!
  @IBOutlet weak var locationInfoContainerView: UIView!
  private var contactShopButton: CakeDesignDetailContactButton!
  private var contactShopButtonBottomConstraint: NSLayoutConstraint!
  
  private var bottomInfoState: BottomInfoState = .cakeDesign {
    didSet {
      updateButtonInfoViewHiddenState()
      updateButtonState()
      updateBottomInfoButtonIndexView()
    }
  }
  
  private(set) var cakeDesigns: [CakeShopCakeDesign] = [] {
    didSet {
      cakeDesignCollectionView.reloadData()
      view.layoutIfNeeded()
      cakeDesignCollectionViewHeight.constant = cakeDesignCollectionView.contentSize.height
    }
  }
  private var cakeShop: CakeShop?
  private var canContactShopButtonMove = false
  private var isScrollDirectionDown = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  func fetchDetail(id: Int) {
    NetworkManager.shared.requestGet(api: .shops,
                                     type: CakeShopDetailResponse.self,
                                     param: "/\(id)") { result in
      switch result {
      case .success(let response):
        self.cakeShop = response.cakeShop
        DispatchQueue.main.async {
          self.updateDetail()
        }
      case .failure(_):
        // TODO: 에러 핸들링
        break
      }
    }
  }
  
  private func saveShop() {
    guard let shopId = cakeShop?.id else { return }
    let urlString = NetworkCommon.API.savedDesigns.urlString + "/\(shopId)"
    NetworkManager.shared.requestPost(urlString: urlString,
                                      type: String.self,
                                      param: "") { (response) in
      switch response {
      case .success(let result):
        print(result)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func cancelSavedShop() {
    guard let shopId = cakeShop?.id else { return }
    let urlString = NetworkCommon.API.savedDesigns.urlString + "/\(shopId)"
    NetworkManager.shared.requestDelete(urlString: urlString,
                                      type: String.self,
                                      param: "") { (response) in
      switch response {
      case .success(let result):
        print(result)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    dismiss(animated: false, completion: nil)
  }
  
  @IBAction func saveButtonDidTap(_ sender: Any) {
    savedButton.isSelected = !savedButton.isSelected
    
    if savedButton.isSelected == true {
      saveShop()
    } else {
      cancelSavedShop()
    }
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
  
  private func updateDetail() {
    guard let cakeShop = self.cakeShop else { return }
    
    shopNameLabel.text = cakeShop.name
    addressLabel.text = cakeShop.fullAddress
    
    savedButton.isSelected = cakeShop.zzim
    savedCountLabel.text = String(cakeShop.zzimCount)
    
    themeLabel.text = cakeShop.themeNames
    updatePriceInfoBySizeStackView(by: cakeShop.sizes)
    creamInfoLabel.text = cakeShop.creamNames
    sheetInfoLabel.text = cakeShop.sheetNames
    
    shopInformationLabel.text = cakeShop.information
    openingTimeLabel.text = cakeShop.operationTime
    pickUpAvailableTimeLabel.text = cakeShop.pickupTime
    phoneLabel.text = cakeShop.telephone
    holidayLabel.text = cakeShop.holiday
    
    cakeDesigns = cakeShop.designs
  }
  
  private func updatePriceInfoBySizeStackView(by sizes: [CakeShopCakeSize]) {
    sizes.forEach {
      let priceLabel = UILabel()
      if $0.size == "" {
        priceLabel.text = "\($0.name) / \(String($0.price).moneyFormat.won)"
      } else {
        priceLabel.text = "\($0.name)(\($0.size)) / \(String($0.price).moneyFormat.won)"
      }
      priceLabel.font = Fonts.spoqaHanSans(weight: .Regular, size: 14)
      priceLabel.textColor = Colors.grayscale05
      priceLabel.translatesAutoresizingMaskIntoConstraints = false
      priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
      priceInfoBySizeStackView.addArrangedSubview(priceLabel)
    }
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

// MARK: - UIScrollViewDelegate

extension ShopDetailViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let canContactShopButtonMoveThreshold: CGFloat = 156
    canContactShopButtonMove = scrollView.contentOffset.y >= canContactShopButtonMoveThreshold
    if canContactShopButtonMove && isScrollDirectionDown {
      hideContactShopButton()
    }
  }
}

// MARK: - UIGestureRecognizerDelegate

extension ShopDetailViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return true
  }
}

// MARK: - Configuration

extension ShopDetailViewController {
  private func configure() {
    configureViews()
    configureCakeDesignCollectionView()
    configureContactShopButton()
    configurePanGesture()
    scrollView.delegate = self
  }
  
  private func configurePanGesture() {
    let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                      action: #selector(handlePanGesture(_ :)))
    panGestureRecognizer.delegate = self
    self.view.addGestureRecognizer(panGestureRecognizer)
  }
  
  @objc private func handlePanGesture(_ sender : UIPanGestureRecognizer) {
    let velocity = sender.velocity(in: scrollView)
    guard abs(velocity.y) > abs(velocity.x) else { return }
    updateIsScrollDirectionDown(velocityY: velocity.y)
    updateContactShopButton(velocityY: velocity.y)
  }
  
  private func updateIsScrollDirectionDown(velocityY: CGFloat) {
    isScrollDirectionDown = velocityY < 0
  }
  
  private func updateContactShopButton(velocityY: CGFloat) {
    let velocityYUpThreshold: CGFloat = 240
    let velocityYDownThreshold: CGFloat = -120
    if velocityY > velocityYUpThreshold {
      showContactShopButton()
    } else if velocityY < velocityYDownThreshold {
      hideContactShopButton()
    }
  }
  
  private func showContactShopButton() {
    let constant = floatingContactShopButtonBottomConstant()
    guard contactShopButton.displayState != .floating else { return }
    contactShopButtonBottomConstraint.constant = constant
    UIView.animate(withDuration: 0.4,
                   delay: 0,
                   usingSpringWithDamping: 1.0,
                   initialSpringVelocity: 0.8,
                   options: .curveEaseOut) {
      self.view.layoutIfNeeded()
    } completion: { _ in
      self.contactShopButton.displayState = .floating
    }
  }
  
  private func hideContactShopButton() {
    guard canContactShopButtonMove, contactShopButton.displayState != .hidden else { return }
    contactShopButtonBottomConstraint.constant = Metric.contactShopButtonBottomSpaceHidden
    UIView.animate(withDuration: 0.5,
                   delay: 0,
                   usingSpringWithDamping: 1.0,
                   initialSpringVelocity: 0.8,
                   options: .curveEaseOut) {
      self.view.layoutIfNeeded()
    } completion: { _ in
      self.contactShopButton.displayState = .hidden
    }
  }
  
  private func configureContactShopButton() {
    contactShopButton = CakeDesignDetailContactButton(type: .system)
    contactShopButton.backgroundColor = Colors.pointB
    contactShopButton.setTitle("가게 연결하기", for: .normal)
    contactShopButton.setTitleColor(Colors.white, for: .normal)
    contactShopButton.titleLabel?.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
    contactShopButton.round(cornerRadius: 8.0)
    view.addSubview(contactShopButton)
    contactShopButton.constraints(topAnchor: nil,
                                  leadingAnchor: view.leadingAnchor,
                                  bottomAnchor: nil,
                                  trailingAnchor: view.trailingAnchor,
                                  padding: .init(top: 0, left: 16, bottom: 0, right: 16),
                                  width: 0, height: 56)
    configureContactShopButtonBottomConstraint()
  }
  
  private func configureContactShopButtonBottomConstraint() {
    let constant = floatingContactShopButtonBottomConstant()
    contactShopButtonBottomConstraint = contactShopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                  constant: constant)
    contactShopButtonBottomConstraint.isActive = true
  }
  
  private func floatingContactShopButtonBottomConstant() -> CGFloat {
    var constant = Self.Metric.contactShopButtonBottomSpaceDefault
    if UIDevice.current.hasNotch {
      constant +=  -UIDevice.minimumBottomSpaceInNotchDevice
    }
    return constant
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
  }
}
