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
      resetSelectedFilterOptions()
      return
    }
    
    if isHighlightedCell {
      showFilterDetailView(type: type)
    } else {
      hideFilterDetailContainerView()
    }
  }
}

// MARK:- FilterDetailView Delegate Method
extension DesignListViewController: FilterDetailViewControllerDelegate {
    
  func filterDetailViewController(didSelectFilterOptionWithType type: FilterCommon.FilterType, values: [String]) {
    highlightedFilterType = type      // 포커스 된 셀 타입 저장
    filterCategoryCollectionView.reloadData()
    selectedFilter[type.key] = values
    fetchCakeDesigns()
    updateSelectedFilterOptions(type: type, values: values)
  }
  
  func updateSelectedFilterOptions(type: FilterCommon.FilterType, values: [String]) {
    guard let value = values.last else {
      selectedFilterOptions = selectedFilterOptions.filter { $0.key != type.key }
      updateSelectedFilterOptionCollectionViewLayout()
      selectedFilterOptionCollectionView.reloadData()
      return
    }
    // 다중 선택이 불가능하면, 하나의 필터 옵션 값만 나오도록 처리
    if FilterManager.shared.isMultiSelectionEnabled(type: type) == false {
      selectedFilterOptions = selectedFilterOptions.filter { $0.key != type.key }
    }
    let option = SelectedFilterOption(key: type.key, value: value)
    if selectedFilterOptions.contains(option) == false {
      selectedFilterOptions.append(option)
    }
    
    let actualSelectedOptions = values.map { SelectedFilterOption(key: type.key, value: $0) }
    selectedFilterOptions = selectedFilterOptions.filter {
      ($0.key != type.key) || (actualSelectedOptions.contains($0))
    }
    
    updateSelectedFilterOptionCollectionViewLayout()
    selectedFilterOptionCollectionView.reloadData()
  }
  
  func filterDetailViewController(shouldDismissFilterDetailViewController viewController: FilterDetailViewController, delay: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) { [weak self] in
      self?.highlightedFilterType = .reset
      self?.filterCategoryCollectionView.reloadData()
      self?.hideFilterDetailContainerView()
    }
  }
}

// MARK:- Private Method
extension DesignListViewController {
  func resetFilter() {
    resetCategoryFilter()
    hideFilterDetailContainerView()
    hideFilterPickUpDate()
  }
  
  func resetCategoryFilter() {
    highlightedFilterType = .reset
    filterCategoryCollectionView.reloadData()
  }
  
  private func resetSelectedFilterOptions() {
    selectedFilter.removeAll()
    selectedFilterOptions = []
    updateSelectedFilterOptionCollectionViewLayout()
    selectedFilterOptionCollectionView.reloadData()
  }
  
  private func hideFilterPickUpDate() {
    guard let detailVC = filterDetailVC else { return }
    detailVC.hidePickUpDateSectionView()
  }
  
  private func showFilterDetailView(type: FilterCommon.FilterType) {
    guard let detailVC = filterDetailVC else { return }
    detailVC.filterType = type
    detailVC.selectedList = selectedFilter[type.key] ?? []
    detailVC.filterTableView.reloadData()
    detailVC.setTableViewHeight()
    detailVC.hidePickUpDateSectionView()
    filterDetailContainerView.isHidden = false
  }
  
  func hideFilterDetailContainerView() {
    filterDetailContainerView.isHidden = true
  }
}
