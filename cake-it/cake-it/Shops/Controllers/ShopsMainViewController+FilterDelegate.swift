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
    highlightedFilterType = type      // 포커스 된 셀 타입 저장
    selectedFilter[type.key] = values
    filterCollectionView.reloadData()
    fetchCakeShops()
    print("🧡🧡 넘어오는 필터 값 배열", values)
    
    updateSelectedFilterOption()
    selectedFilterOptionCollectionView.reloadData()
  }
  
  func filterDetailViewController(_ dismissFilterDetailViewController: FilterDetailViewController, delay: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) { [weak self] in
      self?.highlightedFilterType = .reset
      self?.filterCollectionView.reloadData()
      self?.hideFilterDetailView()
    }
  }
}

// MARK:- Private Method
extension ShopsMainViewController {
  func resetFilter() {
    highlightedFilterType = .reset
    filterDetailVC?.resetSelectedPickUpDate()
    filterCollectionView.reloadData()
    selectedFilterOptionCollectionView.reloadData()
    selectedFilterOptionCollectionViewHeightConstraint.constant = 0
    selectedFilter.removeAll()
    hideFilterDetailView()
    guard let detailVC = filterDetailVC else { return }
    detailVC.hidePickUpDateSectionView()
  }
  
  private func showFilterDetailView(type: FilterCommon.FilterType) {
    guard let detailVC = filterDetailVC else { return }
    detailVC.filterType = type
    detailVC.selectedList = selectedFilter[type.key] ?? []
    filterDetailContainerView.isHidden = false
    switch type {
    case .pickupDate:
      detailVC.updateViewForPickUpDate()
    default:
      detailVC.filterTableView.reloadData()
      detailVC.setTableViewHeight()
      detailVC.hidePickUpDateSectionView()
    }
  }
  
  func hideFilterDetailView() {
    filterDetailContainerView.isHidden = true
  }
}
