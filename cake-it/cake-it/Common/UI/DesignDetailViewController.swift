//
//  DesignDetailViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/04/25.
//

import UIKit

class DesignDetailViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageScrollView: UIScrollView!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var cakeSimpleView: UIView!
  @IBOutlet weak var cakeInformationView: UIView!
  
  static let id = "DesignDetailViewController"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
  }
  
  private func configureView() {
    configureImageScrollView()
    configureCakeSimpleView()
    configureCakeInformationView()

    scrollView.contentSize = CGSize(width: Constants.SCREEN_WIDTH,
                                    height: imageScrollView.frame.height
                                          + cakeSimpleView.frame.height
                                          + cakeInformationView.frame.height )
    scrollView.alwaysBounceVertical = true
  }
  
  private func configureImageScrollView() {
  
    // Image ScrollView Setting
    let colorList: [UIColor] = [.red, .blue, .green, .yellow, .cyan]
    imageScrollView.delegate = self
    
    for i in 0..<colorList.count {
      let subView = UIView()
      subView.frame = CGRect(x: Constants.SCREEN_WIDTH * CGFloat(i),
                             y: 0,
                             width: Constants.SCREEN_WIDTH,
                             height: Constants.SCREEN_WIDTH)
      subView.backgroundColor = colorList[i]
      imageScrollView.addSubview(subView)
    }
    
    imageScrollView.contentSize = CGSize(width: Constants.SCREEN_WIDTH * CGFloat(colorList.count),
                                         height: Constants.SCREEN_WIDTH)
    imageScrollView.isPagingEnabled = true
    imageScrollView.alwaysBounceVertical = false
    imageScrollView.alwaysBounceHorizontal = true
    
    
    // ProgressBar Setting
    progressBar.backgroundColor = .black
    progressBar.tintColor = .white
    progressBar.progress = 1.0 / Float(colorList.count)
  }
  
  private func configureCakeSimpleView() {
    
  }

  
  private func configureCakeInformationView() {
    
  }
  
  
}

extension DesignDetailViewController: UIScrollViewDelegate {

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let currentPageIndex = Int(floor(scrollView.contentOffset.x / Constants.SCREEN_WIDTH))
    let properties = Float(currentPageIndex + 1) / Float(5.0)
    progressBar.progress = properties
  }
}
