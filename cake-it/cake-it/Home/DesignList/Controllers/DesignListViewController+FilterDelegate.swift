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
      fetchCakeDesigns()
      return
    }
    
    if isHighlightedCell { // Filter Title 선택
      if isShowFilterDetailView() {
        updateFilter(type: type)
      } else {
        showFilterDetailView(type: type)
      }
    } else {  // Filter Title 선택 해제
      removeFilterDetailView()
    }
  }
}

// MARK:- FilterDetailView Delegate Method
extension DesignListViewController: FilterDetailViewDelegate {
    
  func filterDetailCellDidTap(type: FilterCommon.FilterType, values: [String]) {
    hightlightedFilterType = type      // 포커스 된 셀 타입 저장
    selectedFilter[type.key] = values
    updateFilterCategoryView()
    fetchCakeDesigns()
  }

  func filterBackgroundViewDidTap() {
    hightlightedFilterType = .reset
    filterCategoryCollectionView.reloadData()
  }
}

// MARK:- Private Method
extension DesignListViewController {
  
  func resetFilter() {
    if isShowFilterDetailView() {
      removeFilterDetailView()
    }

    hightlightedFilterType = .reset
    filterCategoryCollectionView.reloadData()
    selectedFilter.removeAll()
  }
  
  private func updateFilter(type: FilterCommon.FilterType) {
    updateFilterCategoryView()
    updateFilterDetailView(type: type)
  }
  
  private func updateFilterCategoryView() {
    filterCategoryCollectionView.reloadData()
  }
  
  private func updateFilterDetailView(type: FilterCommon.FilterType) {
    if let detailView = filterDetailView {
      detailView.filterType = type
      detailView.selectedList = selectedFilter[type.key] ?? []
      detailView.filterTableView.reloadData()
    }
  }
  
  private func showFilterDetailView(type: FilterCommon.FilterType) {
    filterDetailView = FilterDetailView()
    if let detailView = filterDetailView {
      detailView.filterType = type
      detailView.selectedList = selectedFilter[type.key] ?? []
      detailView.delegate = self
      self.view.addSubview(detailView)
      detailView.constraints(topAnchor: filterCategoryCollectionView.bottomAnchor,
                             leadingAnchor: self.view.leadingAnchor,
                             bottomAnchor: self.view.bottomAnchor,
                             trailingAnchor: self.view.trailingAnchor,
                             padding: UIEdgeInsets(top: FilterCommon.Metric.detailViewTopMargin,
                                                   left: 0,
                                                   bottom: 0,
                                                   right: 0))
    }
  }
  
  func removeFilterDetailView() {
    if let detailView = filterDetailView {
      for subView in detailView.subviews {
        subView.removeFromSuperview()
      }
    }
    filterDetailView?.removeFromSuperview()
  }
  
  private func isShowFilterDetailView() -> Bool {
    return filterDetailView != nil && filterDetailView?.subviews.count ?? 0 > 0
  }
}
