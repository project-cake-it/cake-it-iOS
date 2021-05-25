//
//  DesignListViewController+FilterDelegate.swift
//  cake-it
//
//  Created by seungbong on 2021/05/24.
//

import UIKit

// MARK:- FilterHeaderCell Delegate Method
extension DesignListViewController: FilterHeaderCellDelegate {
  
  func filterHeaderCellDidTap(type: FilterCommon.FilterType, isHighlightedCell: Bool) {
    if type == .reset {
      resetFilter()
      return
    }
    
    if isHighlightedCell { // Filter Title 선택
      if isShowDetailView() {
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
    
  func filterDetailCellDidTap(key: FilterCommon.FilterType, values: [String]) {
    hightlightedFilterType = key      // 포커스 된 셀 타입 저장
    selectedFilterDic[key.title] = values
    filterHeaderCollectionView.reloadData()
    print("🏃🏻‍♂️ seledted: \(selectedFilterDic)") // dictionary 내용 확인을 위해 주석 (개발 후 제거 필요)
  }
  
  func resetFilterView() {
    resetFilter()
  }
}

// MARK:- Private Method
extension DesignListViewController {
  
  private func resetFilter() {
    hightlightedFilterType = .reset
    selectedFilterDic.removeAll()
    filterHeaderCollectionView.reloadData()
    
    if isShowDetailView() {
      removeFilterDetailView()
    }
  }
  
  private func updateFilter(type: FilterCommon.FilterType) {
    updateFilterHeaderView(type: type)
    updateFilterDetailView(type: type)
  }
  
  private func updateFilterHeaderView(type: FilterCommon.FilterType) {
    filterHeaderCollectionView.reloadData()
  }
  
  private func updateFilterDetailView(type: FilterCommon.FilterType) {
    if let detailView = filterDetailView {
      detailView.filterType = type
      detailView.selectedList = selectedFilterDic[type.title] ?? []
      detailView.filterTableView.reloadData()
    }
  }
  
  private func showFilterDetailView(type: FilterCommon.FilterType) {
    filterDetailView = FilterDetailView()
    if let detailView = filterDetailView {
      detailView.filterType = type
      detailView.selectedList = selectedFilterDic[type.title] ?? []
      detailView.delegate = self
      self.view.addSubview(detailView)
      detailView.constraints(topAnchor: filterHeaderCollectionView.bottomAnchor,
                             leadingAnchor: self.view.leadingAnchor,
                             bottomAnchor: self.view.bottomAnchor,
                             trailingAnchor: self.view.trailingAnchor,
                             padding: UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0))
    }
  }
  
  private func removeFilterDetailView() {
    if let detailView = filterDetailView {
      for subView in detailView.subviews {
        subView.removeFromSuperview()
      }
    }
  }
  
  private func isShowDetailView() -> Bool {
    return filterDetailView != nil && filterDetailView?.subviews.count ?? 0 > 0
  }
}
