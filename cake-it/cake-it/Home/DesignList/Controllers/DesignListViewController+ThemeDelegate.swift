//
//  DesignListViewController+ThemeDelegate.swift
//  cake-it
//
//  Created by seungbong on 2021/06/20.
//

import UIKit

extension DesignListViewController: ThemeDetailViewDelegate {
  func themeDetailCellDidTap(type: FilterCommon.FilterTheme) {
    selectedThemeType = type
    let selectedTheme: [String: String] = [FilterCommon.FilterTheme.key: type.value]
    let parameter = selectedTheme.queryString()
    fetchCakeDesigns(parameter: parameter)
    hideThemeList()
  }
}

// Theme 관련 Private Method
extension DesignListViewController {
  func showThemeList() {
    themeDetailView = ThemeDetailView()
    if let detailView = themeDetailView {
      detailView.selectedTheme = selectedThemeType
      detailView.delegate = self
      self.view.addSubview(detailView)
      detailView.constraints(topAnchor: navigationBarView.bottomAnchor,
                             leadingAnchor: self.view.leadingAnchor,
                             bottomAnchor: self.view.bottomAnchor,
                             trailingAnchor: self.view.trailingAnchor,
                             padding: UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0))
    }
  }
  
  func hideThemeList() {
    if let detailView = themeDetailView {
      for subView in detailView.subviews {
        subView.removeFromSuperview()
      }
    }
    themeDetailView?.removeFromSuperview()
  }
  
  func isShowThemeDetailView() -> Bool {
    return themeDetailView != nil && themeDetailView?.subviews.count ?? 0 > 0
  }
}

