//
//  DesignDetailViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/04/25.
//

import UIKit

class DesignDetailViewController: UIViewController {
  
  
  @IBOutlet weak var imageScrollView: UIScrollView!
  
  static let id = "DesignDetailViewController"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pageScrollViewTest()
    
  }
  
  private func pageScrollViewTest() {
    let colorList: [UIColor] = [.red, .blue, .green, .yellow, .cyan]
    imageScrollView.delegate = self
    
    let systemBounds = UIScreen.main.bounds
    for i in 0..<colorList.count {
      let subView = UIView()
      subView.frame = CGRect(x: systemBounds.width * CGFloat(i),
                             y: 0,
                             width: systemBounds.width,
                             height: systemBounds.width)
      subView.backgroundColor = colorList[i]
      imageScrollView.addSubview(subView)
    }
    imageScrollView.isPagingEnabled = true
    imageScrollView.contentSize = CGSize(width: systemBounds.width * CGFloat(colorList.count),
                                         height: systemBounds.width)
    imageScrollView.alwaysBounceVertical = false
    imageScrollView.alwaysBounceHorizontal = true

  }
  
}

extension DesignDetailViewController: UIScrollViewDelegate {
  
}
