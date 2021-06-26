//
//  DesignDetailViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/04/25.
//

import UIKit

final class DesignDetailViewController: BaseViewController {
  
  enum Metric {
    static let imageScrollViewHeight: CGFloat = Constants.SCREEN_WIDTH
    static let bottomInset: CGFloat = 30.0
  }
  
  @IBOutlet weak var navigationBarView: UIView!
  @IBOutlet weak var naviShopNameLabel: UILabel!
  @IBOutlet weak var naviZzimButton: UIButton!
  
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
  @IBOutlet weak var connectShopButton: UIButton! // 가게 연결하기 버튼
  
  @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!

  var cakeDesign: CakeDesign?
  var imageTotalCount: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchCakeImages()
    configureView()
  }
  
  private func fetchCakeImages() {
    guard let cakeImageInfoList = cakeDesign?.designImages else { return }

    for i in 0..<cakeImageInfoList.count {
      let cakeImageUrlString = cakeImageInfoList[i].designImageUrl
      guard let cakeImageUrl = URL(string: cakeImageUrlString) else { return }
      
      DispatchQueue.global().async {
        if let imageData = try? Data(contentsOf: cakeImageUrl) {
          DispatchQueue.main.async {
            let cakeImageView = UIImageView(image: UIImage(data: imageData))
            cakeImageView.frame = CGRect(x: Constants.SCREEN_WIDTH * CGFloat(i),
                                         y: 0,
                                         width: Constants.SCREEN_WIDTH,
                                         height: Constants.SCREEN_WIDTH)
            cakeImageView.contentMode = .scaleAspectFill
            self.imageScrollView.addSubview(cakeImageView)
          }
        }
      }
    }
  }
  
  private func configureView() {
    configureNavigationBar()
    configureScrollView()
    configureImageView()
    configureCakeInformationView()
  }
  
  private func configureNavigationBar() {
    naviShopNameLabel.text = cakeDesign?.shopName
  }
  
  private func configureScrollView() {
    let totalHeight = Metric.imageScrollViewHeight
      + cakeSimpleView.frame.height
      + lineView.frame.height + cakeInformationView.frame.height
      + connectShopButton.frame.height
      + Metric.bottomInset
    contentViewHeightConstraint.constant = totalHeight
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
    addressLabel.text = cakeDesign?.shopPullAddress
    cakeThemeLabel.text = cakeDesign?.themeNames
    for i in 0..<cakePriceBySizeLabels.count {
      guard let sizeInfo = cakeDesign?.sizes[i] else { break }
      cakePriceBySizeLabels[i].text = "\(sizeInfo.name) / \(String(sizeInfo.price).moneyFormat)"
    }
    kindOfCreamsLabel.text = cakeDesign?.creamNames
    kindOfSheetsLabel.text = cakeDesign?.sheetNames

    availableOrderDay.layer.borderWidth = 1
    availableOrderDay.layer.borderColor = Colors.pointB.cgColor
    connectShopButton.round(cornerRadius: 8.0)
  }
  
  @IBAction func naviBackButtonDidTap(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func naviZzimButtonDidTap(_ sender: Any) {
    naviZzimButton.isSelected = !naviZzimButton.isSelected
  }
}

extension DesignDetailViewController: UIScrollViewDelegate {

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let currentPageIndex = Int(floor(scrollView.contentOffset.x / Constants.SCREEN_WIDTH))
    let properties = Float(currentPageIndex + 1) / Float(imageTotalCount)
    progressBar.progress = properties
  }
}