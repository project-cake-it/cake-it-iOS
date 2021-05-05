//
//  SavedItemCakeListSubViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/03.
//

import Foundation
import XLPagerTabStrip

final class CakeListSubViewController: UIViewController, IndicatorInfoProvider {
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: Constants.CAKE_LIST_SUB_VIEW_TITLE)
  }
}
