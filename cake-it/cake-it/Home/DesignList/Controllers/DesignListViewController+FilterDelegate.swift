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
  
  func filterDetailCellDidTap(key: FilterCommon.FilterType, value: String) {
    var savedValues = selectedFilterDic[key.title] ?? []
    // 이미 선택된 경우는 선택 취소
    if selectedFilterDic.keys.contains(key.title) == true && savedValues.contains(value) {
      let index = savedValues.firstIndex(of: value)!
      savedValues.remove(at: index)
    }
    else { // 없는 경우는 추가
      savedValues.append(value)
    }
    hightlightedFilterType = key      // 포커스 된 셀 타입 저장
    selectedFilterDic[key.title] = savedValues
    
    print("highlighted: \(key.korTitle)")    // dictionary 내용 확인을 위해 주석 (개발 후 제거 필요)
    print("seledted: \(selectedFilterDic)") // dictionary 내용 확인을 위해 주석 (개발 후 제거 필요)
    filterHeaderCollectionView.reloadData()
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
      detailView.filterTableView.reloadData()
    }
  }
  
  private func showFilterDetailView(type: FilterCommon.FilterType) {
    filterDetailView = FilterDetailView()
    if let detailView = filterDetailView {
      detailView.filterType = type
      detailView.selectedFilterDic = selectedFilterDic
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
