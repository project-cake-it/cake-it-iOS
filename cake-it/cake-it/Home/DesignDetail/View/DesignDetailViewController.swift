//
//  DesignDetailViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/04/25.
//

import UIKit

final class DesignDetailViewController: BaseViewController {
  
  @IBOutlet weak var naviStoreNameLabel: UILabel!
  @IBOutlet weak var naviZzimButton: UIButton!
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageScrollView: UIScrollView!
  @IBOutlet weak var progressBar: UIProgressView!
  
  @IBOutlet weak var cakeSimpleView: UIView!
  @IBOutlet weak var cakeDesignLabel: UILabel!    // 케이크 디자인 이름
  @IBOutlet weak var addressLabel: UILabel!       // 가게 주소
  @IBOutlet weak var availableOrderDay: UIButton! // 주문 가능 날짜 확인 버튼
  
  @IBOutlet weak var cakeInformationView: UIView!
  @IBOutlet weak var cakeThemeLabel: UILabel!     // 케이크 테마
  @IBOutlet var cakePriceBySizeLabel: [UILabel]!  // 케이크 크기별 가격
  @IBOutlet weak var kindOfCreamsLabel: UILabel!  // 케이크 크림 종류
  @IBOutlet weak var kindOfSheetsLabel: UILabel!  // 케이크 시트 종류
    
  let colorList: [UIColor] = [.red, .blue, .green, .yellow, .cyan]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
  }
  
  private func configureView() {
    configureImageView()
    configureCakeSimpleView()
    configureCakeInformationView()
  }
  
  private func configureImageView() {
    configureImageScrollView()
    configureProgressView()
  }
 
  private func configureImageScrollView() {
    for i in 0..<colorList.count {
      let subView = UIView()
      subView.frame = CGRect(x: Constants.SCREEN_WIDTH * CGFloat(i),
                             y: 0,
                             width: Constants.SCREEN_WIDTH,
                             height: Constants.SCREEN_WIDTH)
      subView.backgroundColor = colorList[i]
      imageScrollView.addSubview(subView)
    }
    
    imageScrollView.delegate = self
    imageScrollView.contentSize = CGSize(width: Constants.SCREEN_WIDTH * CGFloat(colorList.count),
                                         height: Constants.SCREEN_WIDTH)
    imageScrollView.isPagingEnabled = true
    imageScrollView.alwaysBounceVertical = false
    imageScrollView.alwaysBounceHorizontal = true
  }
  
  private func configureProgressView() {
    progressBar.backgroundColor = .black
    progressBar.tintColor = .white
    progressBar.progressViewStyle = .bar
    progressBar.progress = 1.0 / Float(colorList.count)
  }
  
  
  private func configureCakeSimpleView() {
    availableOrderDay.layer.borderWidth = 1
    availableOrderDay.layer.borderColor = Colors.pointB.cgColor
  }

  private func configureCakeInformationView() {
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
    let properties = Float(currentPageIndex + 1) / Float(colorList.count)
    progressBar.progress = properties
  }
}
