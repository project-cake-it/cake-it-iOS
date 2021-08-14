//
//  SavedItemMainViewController.swift
//  cake-it
//
//  Created by Cory on 2021/02/16.
//

import UIKit
import XLPagerTabStrip

final class SavedItemMainViewController: ButtonBarPagerTabStripViewController {
  
  override func viewDidLoad() {
    initXLPagerTabStripUI()
    
    super.viewDidLoad()
    configureView()
  }
  
  private func configureView() {
    navigationController?.navigationBar.isHidden = true
  }
  
  //MARK: - XLPagerTabStrip setting
  func initXLPagerTabStripUI() {
    settings.style.buttonBarBackgroundColor = .white
    settings.style.buttonBarItemBackgroundColor = .white
    settings.style.selectedBarBackgroundColor = Colors.primaryColor
    settings.style.selectedBarHeight = 2.0
    settings.style.buttonBarItemTitleColor = .black
  }
  
  override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    
    let firstSubView = CakeListSubViewController.instantiate(from: "SavedItem")
    let secondSubView = ShopListSubViewController.instantiate(from: "SavedItem")
    
    return [firstSubView, secondSubView]
  }
}
