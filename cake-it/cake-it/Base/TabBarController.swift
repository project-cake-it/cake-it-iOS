//
//  TabBarController.swift
//  cake-it
//
//  Created by seungbong on 2021/08/12.
//

import UIKit
import AudioToolbox

class TabBarController: UITabBarController {
  
  enum TabbarType: Int {
    case home = 0
    case search = 1
    case shop = 2
    case saved = 3
    case myPage = 4
    
    var title: String {
      switch self {
      case .home:   return "홈"
      case .search: return "검색"
      case .shop:   return "가게"
      case .saved:  return "찜"
      case .myPage: return "마이페이지"
      }
    }
    
    var imageName: String {
      switch self {
      case .home:   return "tab-home"
      case .search: return "tab-search"
      case .shop:   return "tab-store"
      case .saved:  return "tab-mark"
      case .myPage: return "tab-mypage"
      }
    }
    
    var selectedImageName: String {
      switch self {
      case .home:   return "tab-home-clicked"
      case .search: return "tab-search-clicked"
      case .shop:   return "tab-store-clicked"
      case .saved:  return "tab-mark-clicked"
      case .myPage: return "tab-mypage-clicked"
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    configureTabBarItem()
  }
  
  private func initUI() {
    tabBar.tintColor = Colors.primaryColor
  }
  
  func configureTabBarItem() {
    guard let tabbarItems  = self.tabBar.items else { return }
    
    for i in 0..<tabbarItems.count {
      guard let tabBarType = TabbarType(rawValue: i) else { return }
      tabbarItems[i].title = tabBarType.title
      tabbarItems[i].image = UIImage(named: tabBarType.imageName)
      tabbarItems[i].selectedImage = UIImage(named: tabBarType.selectedImageName)
    }
  }
  
  func hideTabBar() {
    DispatchQueue.main.async {
      UIView.animateCurveEaseOut(withDuration: 0.5, animation: {
        self.tabBar.frame.origin.y = Constants.SCREEN_HEIGHT
      })
    }
  }
  
  func showTabBar() {
    DispatchQueue.main.async {
      UIView.animateCurveEaseOut(withDuration: 0.5, animation: {
        self.tabBar.frame.origin.y = Constants.SCREEN_HEIGHT - self.tabBar.frame.size.height
      })
    }
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    AudioServicesPlayAlertSound(1519) // weak boom
  }
}
