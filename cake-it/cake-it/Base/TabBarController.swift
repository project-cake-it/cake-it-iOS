//
//  TabBarController.swift
//  cake-it
//
//  Created by seungbong on 2021/08/12.
//

import UIKit
import AudioToolbox

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initUI()
  }
  
  private func initUI() {
    tabBar.tintColor = Colors.primaryColor
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    AudioServicesPlayAlertSound(1519) // weak boom
  }
}
