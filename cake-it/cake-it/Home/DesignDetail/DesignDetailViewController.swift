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
  @IBOutlet weak var availableOrderDay: UIButton! // 주문 가능 날짜 확인 버튼
  @IBOutlet weak var lineView: UIView!
  
  @IBOutlet weak var cakeInformationView: UIView!
  @IBOutlet weak var cakeThemeLabel: UILabel!     // 케이크 테마
  @IBOutlet var cakePriceBySizeLabels: [UILabel]! // 케이크 크기별 가격
  @IBOutlet weak var kindOfCreamsLabel: UILabel!  // 케이크 크림 종류
  @IBOutlet weak var kindOfSheetsLabel: UILabel!  // 케이크 시트 종류
  @IBOutlet weak var connectShopButton: UIButton! // 가게 연결하기 버튼, 실제로 사용하지 않고 높이만 잡아주는 버튼
  
  @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
  
  private var contactShopButton: CakeDesignDetailContactButton!
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
  
  private func fetchCakeDetail() {
    NetworkManager.shared.requestGet(api: .designs,
                                     type: CakeDesign.Response.self,
                                     param: "/\(designID)") { (response) in
      switch response {
      case .success(let result):
        self.cakeDesign = result.design
        self.configureView()
        self.fetchCakeImages()
      case .failure(let error):
        print(error)
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
  
  @objc private func contactShopButtonDidTap() {
    guard let shopChannel = cakeDesign?.shopChannel,
          let shopIdentifier = shopChannel.split(separator: "/").last,
          let url = TalkApi.shared.makeUrlForChannelChat(channelPublicId: String(shopIdentifier)) else {
      return
    }
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
      // TODO: 에러 처리
    }
  }
}

// MARK: - UIScrollViewDelegate
extension DesignDetailViewController: UIScrollViewDelegate {

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    switch imageScrollView {
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
      + connectShopButton.frame.height
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
    progressBar.tintColor = Colors.pointB
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

    availableOrderDay.layer.borderWidth = 1
    availableOrderDay.layer.borderColor = Colors.pointB.cgColor
    connectShopButton.isHidden = true
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
  
  @IBAction func naviSaveButtonDidTap(_ sender: Any) {
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
    contactShopButton = CakeDesignDetailContactButton(type: .system)
    contactShopButton.addTarget(self, action: #selector(contactShopButtonDidTap), for: .touchUpInside)
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
}
