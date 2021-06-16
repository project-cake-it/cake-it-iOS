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
    
  func filterDetailCellDidTap(type: FilterCommon.FilterType, values: [String]) {
    hightlightedFilterType = type      // 포커스 된 셀 타입 저장
    selectedFilter[type.key] = values
    requestDesignWithFilter()
    print("🏃🏻‍♂️ selected: \(selectedFilter)") // dictionary 내용 확인을 위해 주석 (개발 후 제거 필요)
  }

  func backgroundViewDidTap() {
    hightlightedFilterType = .reset
    filterCategoryCollectionView.reloadData()
  }
}

// MARK:- Private Method
extension DesignListViewController {
  
  private func requestDesignWithFilter() {
    let parameter = selectedFilter.queryString()
    NetworkManager.shared.requestGet(api: .designs,
                                     type: [CakeDesign].self,
                                     param: parameter) { (respons) in
      switch respons {
      case .success(let designs):
        self.cakeDesigns = designs
        self.designsCollectionView.reloadData()
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func resetFilter() {
    if isShowDetailView() {
      removeFilterDetailView()
    }

    hightlightedFilterType = .reset
    filterCategoryCollectionView.reloadData()
    selectedFilter.removeAll()
    requestDesignWithFilter()
  }
  
  private func updateFilter(type: FilterCommon.FilterType) {
    updateFilterCategoryView(type: type)
    updateFilterDetailView(type: type)
  }
  
  private func updateFilterCategoryView(type: FilterCommon.FilterType) {
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
