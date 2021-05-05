//
//  SavedItemStoreListSubViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/03.
//

import Foundation
import XLPagerTabStrip

final class StoreListSubViewController: UIViewController, IndicatorInfoProvider {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: Constants.STORE_LIST_SUB_VIEW_TITLE)
  }
}
