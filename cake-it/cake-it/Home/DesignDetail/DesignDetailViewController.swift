//
//  DesignDetailViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/04/25.
//

import UIKit
import KakaoSDKTalk
import Kingfisher

final class DesignDetailViewController: BaseViewController {
  
  enum Metric {
    static let imageScrollViewHeight: CGFloat = Constants.SCREEN_WIDTH
    static let bottomInset: CGFloat = 30.0
    static let contactShopButtonHeight: CGFloat = 48
    static let contactShopButtonBottomSpaceDefault: CGFloat = -16
    static let contactShopButtonBottomSpaceHidden: CGFloat = 200
  }
  
  @IBOutlet weak var navigationBarView: UIView!
  @IBOutlet weak var naviShopNameLabel: UILabel!
  @IBOutlet weak var naviSaveButton: UIButton!
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageScrollView: UIScrollView!
  @IBOutlet weak var progressBar: UIProgressView!
  
  @IBOutlet weak var cakeSimpleView: UIView!
  @IBOutlet weak var cakeDesignLabel: UILabel!    // 케이크 디자인 이름
  @IBOutlet weak var addressLabel: UILabel!       // 가게 주소
  @IBOutlet weak var orderAvailableDateButton: OrderAvailableDateButton! // 주문 가능 날짜 확인 버튼
  @IBOutlet weak var lineView: UIView!
  
  @IBOutlet weak var cakeInformationView: UIView!
  @IBOutlet weak var cakeThemeLabel: UILabel!     // 케이크 테마
  @IBOutlet var cakePriceBySizeLabels: [UILabel]! // 케이크 크기별 가격
  @IBOutlet weak var kindOfCreamsLabel: UILabel!  // 케이크 크림 종류
  @IBOutlet weak var kindOfSheetsLabel: UILabel!  // 케이크 시트 종류
  private var loadingBlockView = LoadingBlockView()
  
  @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
  
  private var contactShopButton: ContactToShopButton!
  private var contactShopButtonBottomConstraint: NSLayoutConstraint!
  private var canContactShopButtonMove = false
  private var isScrollDirectionDown = false

  var designID: Int = 0
  var cakeDesign: CakeDesign?
  var imageTotalCount: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchCakeDetail()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    hideTabBar()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    showTabBar()
  }
  
  private func fetchCakeDetail() {
    NetworkManager.shared.requestGet(api: .designs,
                                     type: CakeDesign.Response.self,
                                     param: "/\(designID)") { (response) in
      switch response {
      case .success(let result):
        self.cakeDesign = result.design
        DispatchQueue.main.async {
          self.configureView()
          self.fetchCakeImages()
          self.dismissLoadingBlockView()
        }
      case .failure(_):
        DispatchQueue.main.async {
          let alertController = UIAlertController(title: Constants.ALERT_NETWORK_ERROR_TITLE,
                                                  message: Constants.ALERT_NETWORK_ERROR_MESSAGE,
                                                  preferredStyle: .alert)
          let doneAction = UIAlertAction(title: Constants.COMMON_ALERT_OK, style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
          }
          alertController.addAction(doneAction)
          self.present(alertController, animated: true, completion: nil)
        }
      }
    }
  }
  
  private func fetchCakeImages() {
    guard let cakeImageInfoList = cakeDesign?.designImages else { return }

    for i in 0..<cakeImageInfoList.count {
      let cakeImageUrlString = cakeImageInfoList[i].designImageUrl
      guard let cakeImageUrl = URL(string: cakeImageUrlString) else { return }
      let cakeImageView = UIImageView()
      cakeImageView.kf.setImage(with: cakeImageUrl)
      cakeImageView.frame = CGRect(x: Constants.SCREEN_WIDTH * CGFloat(i),
                                   y: 0,
                                   width: Constants.SCREEN_WIDTH,
                                   height: Constants.SCREEN_WIDTH)
      cakeImageView.contentMode = .scaleAspectFill
      self.imageScrollView.addSubview(cakeImageView)
    }
  }
  
  private func dismissLoadingBlockView() {
    UIView.animateCurveEaseOut(withDuration: 0.35, delay: 0.25) {
      self.loadingBlockView.alpha = 0
    } completion: { [weak self] in
      self?.loadingBlockView.removeFromSuperview()
    }
  }
  
  @IBAction func orderAvailableDateButtonDidTap(_ sender: Any) {
    // TODO: -> 케이크 디자인 리스트에서 주문 가능 날짜 배열로 변경
    let availableDates = cakeDesign?.orderAvailabilityDates ?? []
    let dateViewController = CakeOrderAvailableDateViewController(availableDates: availableDates)
    dateViewController.modalPresentationStyle = .overFullScreen
    present(dateViewController, animated: false)
  }
  
  @objc private func contactShopButtonDidTap() {
    guard let shopChannel = cakeDesign?.shopChannel,
          let shopIdentifier = shopChannel.split(separator: "/").last,
          let url = TalkApi.shared.makeUrlForChannelChat(channelPublicId: String(shopIdentifier)) else {
      return
    }
    
    let alertController = UIAlertController(
      title: "케이크 가게와 주문 상담을 시작할까요?",
      message: "카카오톡 채널 앱으로 이동해요!",
      preferredStyle: .actionSheet)
    let okAction = UIAlertAction(title: "예", style: .default) { _ in
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        self.logContactShopEventInCakeDesignDetail()
      } else {
        // TODO: 에러 처리
      }
    }
    let closeAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
    alertController.addAction(okAction)
    alertController.addAction(closeAction)
    present(alertController, animated: true, completion: nil)
  }
  
  private func logContactShopEventInCakeDesignDetail() {
    guard let detailData = cakeDesign else { return }
    FirebaseAnalyticsManager.shared.logContactShopEventInCakeDesignDetail(
      shopID: String(detailData.shopId),
      shopName: detailData.shopName,
      shopAddress: detailData.shopAddress,
      designID: String(detailData.id),
      designName: detailData.name)
  }
  
  private func hideTabBar() {
    guard let tabbar = self.tabBarController as? TabBarController else { return }
    tabbar.hideTabBar()
  }
  
  private func showTabBar() {
    guard let tabbar = self.tabBarController as? TabBarController else { return }
    tabbar.showTabBar()
  }
}

// MARK: - UIScrollViewDelegate
extension DesignDetailViewController: UIScrollViewDelegate {

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    switch scrollView {
    case self.scrollView:
      let canContactShopButtonMoveThreshold: CGFloat = 156
      canContactShopButtonMove = scrollView.contentOffset.y >= canContactShopButtonMoveThreshold
      if canContactShopButtonMove && isScrollDirectionDown {
        hideContactShopButton()
      }
    case imageScrollView:
      let currentPageIndex = Int(floor(scrollView.contentOffset.x / Constants.SCREEN_WIDTH))
      let properties = Float(currentPageIndex + 1) / Float(imageTotalCount)
      progressBar.progress = properties
    default:
      break
    }
  }
}

// MARK: - UIGestureRecognizerDelegate

extension DesignDetailViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return true
  }
}

// MARK: - Configuration

extension DesignDetailViewController {
  private func configureView() {
    configureNavigationBar()
    configureScrollView()
    configureImageView()
    configureCakeInformationView()
    configureContactShopButton()
    configurePanGesture()
    configureNavigationPopGesture()
    configureLoadingBlockView()
  }
  
  private func configureNavigationBar() {
    guard let cakeDesign = cakeDesign else { return }
    naviSaveButton.isSelected = cakeDesign.zzim
    naviShopNameLabel.text = cakeDesign.shopName
  }
  
  private func configureScrollView() {
    let totalHeight = Metric.imageScrollViewHeight
      + cakeSimpleView.frame.height
      + lineView.frame.height + cakeInformationView.frame.height
      + Metric.contactShopButtonHeight
      + Metric.bottomInset
    contentViewHeightConstraint.constant = totalHeight
    scrollView.delegate = self
    scrollView.bounces = true
  }
  
  private func configureImageView() {
    configureImageScrollView()
    configureProgressBar()
  }
 
  private func configureImageScrollView() {
    guard let cakeImageInfoList = cakeDesign?.designImages else { return }
    imageTotalCount = cakeImageInfoList.count
    imageScrollView.delegate = self
    imageScrollView.isPagingEnabled = true
    imageScrollView.alwaysBounceVertical = false
    imageScrollView.alwaysBounceHorizontal = true
    imageScrollView.contentSize = CGSize(width: Constants.SCREEN_WIDTH * CGFloat(imageTotalCount),
                                         height: Constants.SCREEN_WIDTH)
  }
  
  private func configureProgressBar() {
    if imageTotalCount == 0 {
      progressBar.isHidden = true
      return
    }
    progressBar.backgroundColor = Colors.white
    progressBar.tintColor = Colors.primaryColor
    progressBar.progressViewStyle = .bar
    progressBar.progress = 1.0 / Float(imageTotalCount)
  }

  private func configureCakeInformationView() {
    cakeDesignLabel.text = cakeDesign?.name
    addressLabel.text = cakeDesign?.shopFullAddress
    cakeThemeLabel.text = cakeDesign?.themeNames
    for i in 0..<cakePriceBySizeLabels.count {
      if cakeDesign?.sizes.count ?? 0 <= i { break }
      guard let sizeInfo = cakeDesign?.sizes[i] else { break }
      cakePriceBySizeLabels[i].text = "\(sizeInfo.name) / \(String(sizeInfo.price).moneyFormat.won)"
    }
    kindOfCreamsLabel.text = cakeDesign?.creamNames
    kindOfSheetsLabel.text = cakeDesign?.sheetNames

    orderAvailableDateButton.layer.borderWidth = 1
    orderAvailableDateButton.layer.borderColor = Colors.primaryColor.cgColor
    orderAvailableDateButton.round(cornerRadius: 4)
  }
  
  private func configureLoadingBlockView() {
    view.addSubview(loadingBlockView)
    view.bringSubviewToFront(loadingBlockView)
    loadingBlockView.fillSuperView()
  }
  
  /// 케이크 디자인 찜하기
  private func saveDesign() {
    guard let designId = cakeDesign?.id else { return }
    let urlString = NetworkCommon.API.savedDesigns.urlString + "/\(designId)"
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
  
  /// 케이크 디자인 찜하기 취소
  private func cancelSavedDesign() {
    guard let designId = cakeDesign?.id else { return }
    let urlString = NetworkCommon.API.savedDesigns.urlString + "/\(designId)"
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

  
  @IBAction func naviBackButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func naviTtileButtonDidTap(_ sender: Any) {
    guard let cakeDesign = cakeDesign else { return }
    
    let id = String(describing: ShopDetailViewController.self)
    let storyboard = UIStoryboard(name: "Shops", bundle: nil)
    if let detailVC = storyboard.instantiateViewController(identifier: id) as? ShopDetailViewController {
      detailVC.fetchDetail(id: cakeDesign.shopId)
      navigationController?.pushViewController(detailVC, animated: true)
    }
  }
  
  @IBAction func naviSaveButtonDidTap(_ sender: Any) {
    if LoginManager.shared.verifyAccessToken() == false {
      showLoginAlert()
      return
    }
    
    naviSaveButton.isSelected = !naviSaveButton.isSelected
    if naviSaveButton.isSelected == true {
      saveDesign()
    } else {
      cancelSavedDesign()
    }
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
      constant +=  -UIDevice.minimumBottomSpaceInNotchDevice
    }
    return constant
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
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    if let loginViewController = storyboard.instantiateViewController(withIdentifier: LoginViewController.id) as? LoginViewController{
      loginViewController.modalPresentationStyle = .overFullScreen
      loginViewController.delegate = self
      present(loginViewController, animated: true, completion: nil)
    }
  }
  
  private func configureNavigationPopGesture() {
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
  }
}

extension DesignDetailViewController : LoginViewControllerDelegate {
  func loginViewController(didFinishLogIn viewController: LoginViewController, _ success: Bool) {
    if success {
      viewController.dismiss(animated: true) {
        self.view.showToast(message: Constants.TOAST_MESSAGE_LOGIN)
      }
    }
  }
}
