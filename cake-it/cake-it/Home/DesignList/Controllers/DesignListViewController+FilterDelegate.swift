//
//  DesignListViewController+FilterDelegate.swift
//  cake-it
//
//  Created by seungbong on 2021/05/24.
//

import UIKit

// MARK:- FilterCategoryCell Delegate Method
extension DesignListViewController: FilterCategoryCellDelegate {
  func filterCategoryCellDidTap(type: FilterCommon.FilterType, isHighlightedCell: Bool) {
    if type == .reset {
      resetFilter()
      return
    }
    
    if isHighlightedCell {
      showFilterDetailView(type: type)
    } else {
      hideFilterDetailView()
    }
  }
}

// MARK:- FilterDetailView Delegate Method
extension DesignListViewController: FilterDetailViewDelegate {
    
  func filterDetailCellDidTap(type: FilterCommon.FilterType, values: [String]) {
    filterCategoryCollectionView.reloadData()
    hightlightedFilterType = type      // 포커스 된 셀 타입 저장
    selectedFilter[type.key] = values
    fetchCakeDesigns()
  }

  func filterBackgroundViewDidTap() {
    hightlightedFilterType = .reset
    filterCategoryCollectionView.reloadData()
    hideFilterDetailView()
  }
}

// MARK:- Private Method
extension DesignListViewController {
  func resetFilter() {
    selectedFilter.removeAll()
    resetCategoryFilter()
    hideFilterDetailView()
  }
  
  func resetCategoryFilter() {
    hightlightedFilterType = .reset
    filterCategoryCollectionView.reloadData()
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
