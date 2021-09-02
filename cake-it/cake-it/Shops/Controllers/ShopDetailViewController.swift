//
//  ShopDetailViewController.swift
//  cake-it
//
//  Created by Cory on 2021/05/08.
//

import UIKit
import KakaoSDKTalk

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
  @IBOutlet weak var orderAvailableDateButton: OrderAvailableDateButton!
  
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
  @IBOutlet var mapContainerView: UIView!
  private var contactShopButton: ContactToShopButton!
  private var contactShopButtonBottomConstraint: NSLayoutConstraint!
  private var mapView: MTMapView?
  private var loadingBlockView = UIView()
  
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
  
  private let MAP_ZOOM_LEVEL_DEFAULT: Int32 = 0
  private let MAP_CONNECT_URL_STRING = "kakaomap://place?id="
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  //MARK: - Public Method
  func fetchDetail(id: Int) {
    NetworkManager.shared.requestGet(api: .shops,
                                     type: CakeShopDetailResponse.self,
                                     param: "/\(id)") { result in
      switch result {
      case .success(let response):
        self.dismissLoadingBlockView()
        self.cakeShop = response.cakeShop
        DispatchQueue.main.async {
          self.updateDetail()
          self.updateMapView()
        }
      case .failure(_):
        self.dismissLoadingBlockView()
        let alertController = UIAlertController(title: "네트워크 오류",
                                                message: "현재 네트워크 오류로 인하여 정보를 불러올 수 없어요.\n잠시후 다시 시도해주세요.",
                                                preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "확인", style: .default) { _ in
          self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil)
      }
    }
  }
  
  private func dismissLoadingBlockView() {
    UIView.animateCurveEaseOut(withDuration: 0.25, delay: 0.5) {
      self.loadingBlockView.alpha = 0
    } completion: { [weak self] in
      self?.loadingBlockView.removeFromSuperview()
    }
  }
  
  //MARK: - Private Method
  private func saveShop() {
    guard let shopID = cakeShop?.id else { return }
    let urlString = NetworkCommon.API.savedShops.urlString + "/\(shopID)"
    NetworkManager.shared.requestPost(urlString: urlString,
                                      type: String.self,
                                      param: "") { (response) in
      switch response {
      case .success(_):
        self.fetchDetail(id: shopID)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func cancelSavedShop() {
    guard let shopId = cakeShop?.id else { return }
    let urlString = NetworkCommon.API.savedShops.urlString + "/\(shopId)"
    NetworkManager.shared.requestDelete(urlString: urlString,
                                      type: String.self,
                                      param: "") { (response) in
      switch response {
      case .success(_):
        self.fetchDetail(id: shopId)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func saveButtonDidTap(_ sender: Any) {
    if LoginManager.shared.verifyAccessToken() == false {
      showLoginAlert()
      return
    }
    
    savedButton.isSelected = !savedButton.isSelected
    if savedButton.isSelected == true {
      saveShop()
    } else {
      cancelSavedShop()
    }
  }
  
  @IBAction func orderAvailableDateButtonDidTap(_ sender: Any) {
    let availableDates = cakeShop?.orderAvailableDates ?? []
    let dateViewController = CakeOrderAvailableDateViewController(availableDates: availableDates)
    dateViewController.modalPresentationStyle = .overFullScreen
    present(dateViewController, animated: false)
  }
  
  @IBAction func cakeDesignButtonDidTap(_ sender: Any) {
    bottomInfoState = .cakeDesign
  }
  
  @IBAction func shopInfoButtonDidTap(_ sender: Any) {
    bottomInfoState = .shopInfo
  }
  
  @IBAction func copyAddressButtonDidTap(_ sender: Any) {
    UIPasteboard.general.string = cakeShop?.fullAddress
    view.showToast(message: Constants.SHOP_ADDRESS_COPY_COMPLETE)
  }
  
  @IBAction func showMapButtonDidTap(_ sender: Any) {
    guard let cakeShop = cakeShop else { return }
    
    let urlString = "kakaomap://look?p=\(cakeShop.latitude),\(cakeShop.logitude)"
    
    guard let url = URL.init(string: urlString) else { return }
    
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
      view.showToast(message: Constants.COMMON_NET_ERROR)
    }
  }
  
  @objc private func contactShopButtonDidTap() {
    guard let shopChannel = cakeShop?.shopChannel,
          let shopIdentifier = shopChannel.split(separator: "/").last,
          let url = TalkApi.shared.makeUrlForChannelChat(channelPublicId: String(shopIdentifier)) else {
      return
    }
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
//       TODO: 에러 처리
    }
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
    priceInfoBySizeStackView.removeAllArrangedSubviews()
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
    button.setTitleColor(Colors.primaryColor, for: .normal)
    button.titleLabel?.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
  }
  
  private func resetBottomInfoButton(_ button: UIButton) {
    button.setTitleColor(Colors.grayscale05, for: .normal)
    button.titleLabel?.font = Fonts.spoqaHanSans(weight: .Medium, size: 15)
  }
  
  private func updateMapView() {
    mapView = MTMapView(frame: self.mapContainerView.bounds)
    guard let mapView = mapView else { return }
    guard let cakeShop = cakeShop else { return }
    guard let latitude = Double(cakeShop.latitude),
          let longitude = Double(cakeShop.logitude) else { return }

    let mapPoint = MTMapPoint.init(geoCoord: .init(latitude: latitude, longitude: longitude))
    mapView.baseMapType = .standard
    mapView.setMapCenter(mapPoint,
                         zoomLevel: MAP_ZOOM_LEVEL_DEFAULT,
                         animated: true)
    
    let pinItem = MTMapPOIItem()
    pinItem.mapPoint = mapPoint
    pinItem.markerType = .redPin
    pinItem.itemName = cakeShop.name
    mapView.add(pinItem)
    self.mapContainerView.addSubview(mapView)
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
    configureLabelLineSpacing()
    configureLoadingBlockView()
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
    contactShopButton = ContactToShopButton()
    contactShopButton.addTarget(self, action: #selector(contactShopButtonDidTap), for: .touchUpInside)
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
      constant += -UIDevice.minimumBottomSpaceInNotchDevice
    }
    return constant
  }
  
  private func configureCakeDesignCollectionView() {
    cakeDesignCollectionView.dataSource = self
    cakeDesignCollectionView.delegate = self
  }
  
  private func configureViews() {
    orderAvailableDateButton.layer.borderWidth = 1.0
    orderAvailableDateButton.layer.borderColor = Colors.primaryColor.cgColor
    orderAvailableDateButton.round(cornerRadius: 4.0, clipsToBounds: true)
    locationInfoContainerView.addBorder(borderColor: Colors.grayscale02, borderWidth: 1.0)
    bottomInfoShopInfoView.isHidden = true
    updateBottomInfoButton(cakeDesignButton)
    resetBottomInfoButton(shopInfoButton)
  }
  
  private func showLoginAlert() {
    let alertController = UIAlertController(title: "",
                                            message: Constants.SAVED_ITEM_MESSAGE,
                                            preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: Constants.COMMON_ALERT_OK,
                                      style: .default) { _ in
      self.moveToLoginPage()
    }
    alertController.addAction(confirmAction)
    self.present(alertController, animated: false, completion: nil)
  }
  
  private func moveToLoginPage() {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let loginViewController = storyboard.instantiateViewController(withIdentifier: LoginViewController.id)
    loginViewController.modalPresentationStyle = .overFullScreen
    present(loginViewController, animated: true, completion: nil)
  }
  
  private func configureLabelLineSpacing() {
    [themeLabel, creamInfoLabel,sheetInfoLabel,
     shopInformationLabel, openingTimeLabel, pickUpAvailableTimeLabel].forEach {
      $0?.setLineSpacing(4.4)
    }
  }
  
  private func configureLoadingBlockView() {
    loadingBlockView = UIView()
    loadingBlockView.backgroundColor = Colors.white
    loadingBlockView.alpha = 1
    view.addSubview(loadingBlockView)
    view.bringSubviewToFront(loadingBlockView)
    loadingBlockView.fillSuperView()
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    activityIndicatorView.color = Colors.primaryColor02
    loadingBlockView.addSubview(activityIndicatorView)
    activityIndicatorView.startAnimating()
    activityIndicatorView.centerInSuperView()
  }
}
