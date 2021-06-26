//
//  DesignListViewController+ThemeDelegate.swift
//  cake-it
//
//  Created by seungbong on 2021/06/20.
//

import UIKit

extension DesignListViewController: ThemeDetailViewDelegate {
  func themeDetailCellDidTap(type: FilterCommon.FilterTheme) {
    if selectedThemeType != type {
      selectedThemeType = type
      resetFilter()
      fetchCakeDesigns()
    }
    hideThemeDetailView()
  }
}

// Theme 관련 Private Method
extension DesignListViewController {
  func showThemeDetailView() {
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
    rotateThemeArrowImageView(arrowDirection: .up)
  }
  
  func hideThemeDetailView() {
    if let detailView = themeDetailView {
      for subView in detailView.subviews {
        subView.removeFromSuperview()
      }
    }
    themeDetailView?.removeFromSuperview()
    rotateThemeArrowImageView(arrowDirection: .down)
  }
  
  private func rotateThemeArrowImageView(arrowDirection: NaviArrowDirection) {
    UIView.animate(withDuration: 0.2) {
      if arrowDirection == .up {
        self.navigationBarTitleArrowIcon.transform = CGAffineTransform(rotationAngle: .pi)
      } else {
        self.navigationBarTitleArrowIcon.transform = CGAffineTransform(rotationAngle: 0)
      }
    }
  }
  
  func isShowThemeDetailView() -> Bool {
    return themeDetailView != nil && themeDetailView?.subviews.count ?? 0 > 0
  }
}

