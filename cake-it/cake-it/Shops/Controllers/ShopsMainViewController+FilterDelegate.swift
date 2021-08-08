//
//  ShopsMainViewController+FilterDelegate.swift
//  cake-it
//
//  Created by seungbong on 2021/06/20.
//

import UIKit

extension ShopsMainViewController: FilterCategoryCellDelegate {
  func filterCategoryCellDidTap(type: FilterCommon.FilterType, isHighlightedCell: Bool) {
    if type == .reset {
      resetFilter()
      fetchCakeShops()
      return
    }

    if isHighlightedCell {
      showFilterDetailView(type: type)
    } else {
      hideFilterDetailView()
    }
  }
}

extension ShopsMainViewController: FilterDetailViewDelegate {
  func filterDetailCellDidTap(type: FilterCommon.FilterType, values: [String]) {
    hightlightedFilterType = type      // 포커스 된 셀 타입 저장
    selectedFilter[type.key] = values
    filterCollectionView.reloadData()
    fetchCakeShops()
  }
  
  func filterBackgroundViewDidTap() {
    hightlightedFilterType = .reset
    filterCollectionView.reloadData()
    hideFilterDetailView()
  }
}

// MARK:- Private Method
extension ShopsMainViewController {
  func resetFilter() {
    hightlightedFilterType = .reset
    filterCollectionView.reloadData()
    selectedFilter.removeAll()
    hideFilterDetailView()
  }
  
  private func showFilterDetailView(type: FilterCommon.FilterType) {
    guard let detailVC = filterDetailVC else { return }
    detailVC.filterType = type
    detailVC.selectedList = selectedFilter[type.key] ?? []
    detailVC.filterTableView.reloadData()
    filterDetailContainerView.isHidden = false
  }
  
  func hideFilterDetailView() {
    filterDetailContainerView.isHidden = true
  }
}
