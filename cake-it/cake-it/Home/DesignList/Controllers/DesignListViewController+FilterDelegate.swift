//
//  DesignListViewController+FilterDelegate.swift
//  cake-it
//
//  Created by seungbong on 2021/05/24.
//

import UIKit

extension DesignListViewController: FilterHeaderCellDelegate {
  func filterHeaderCellDidTap(type: FilterCommon.FilterType, isHighlighted: Bool) {
    if type == .reset {
      resetFilter()
      return
    }

    if isHighlighted { // Filter Title 선택
      if isShowDetailView() {
        updateFilterDetailView(type: type)
      } else {
        showFilterDetailView(type: type)
      }
    } else {  // Filter Title 선택 해제
      removeFilterDetailView()
    }
  }
  
  private func resetFilter() {
    selectedFilterDic.removeAll()
    filterHeaderCollectionView.reloadData()
    if isShowDetailView() {
      filterDetailView?.filterTableView.reloadData()
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
  
  private func updateFilterDetailView(type: FilterCommon.FilterType) {
    if let detailView = filterDetailView {
      detailView.filterType = type
      detailView.filterTableView.reloadData()
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
    selectedFilterDic[key.title] = savedValues
    print(selectedFilterDic) // dictionary 내용 확인을 위해 주석 (개발 후 제거 필요)
    
    filterHeaderCollectionView.reloadData()
  }
}
