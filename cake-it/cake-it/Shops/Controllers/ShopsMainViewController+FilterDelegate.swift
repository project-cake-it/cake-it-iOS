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

extension ShopsMainViewController: FilterDetailViewDelegate {
  func filterDetailCellDidTap(type: FilterCommon.FilterType, values: [String]) {
    hightlightedFilterType = type      // 포커스 된 셀 타입 저장
    selectedFilter[type.key] = values
    requestShopListWithFilter()
    print("🏃🏻‍♂️ selected: \(selectedFilter)") // dictionary 내용 확인을 위해 주석 (개발 후 제거 필요)
  }
  
  func backgroundViewDidTap() {
    hightlightedFilterType = .reset
    filterCollectionView.reloadData()
  }
}

// MARK:- Private Method
extension ShopsMainViewController {
  
  // TODO: 가게리스트 요청 코드 구현 필요
  private func requestShopListWithFilter() {
//    let parameter = selectedFilter.queryString()
//    NetworkManager.shared.requestGet(api: .shops,
//                                     type: [CakeDesign].self,
//                                     param: parameter) { (respons) in
//      switch respons {
//      case .success(let designs):
//        self.cakeDesigns = designs
        self.filterCollectionView.reloadData()
//
//      case .failure(let error):
//        print(error.localizedDescription)
//      }
//    }
  }
  
  private func resetFilter() {
    if isShowDetailView() {
      removeFilterDetailView()
    }

    hightlightedFilterType = .reset
    filterCollectionView.reloadData()
    selectedFilter.removeAll()
    requestShopListWithFilter()
  }
  
  private func updateFilter(type: FilterCommon.FilterType) {
    updateFilterCategoryView(type: type)
    updateFilterDetailView(type: type)
  }
  
  private func updateFilterCategoryView(type: FilterCommon.FilterType) {
    filterCollectionView.reloadData()
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
      detailView.constraints(topAnchor: filterCollectionView.bottomAnchor,
                             leadingAnchor: self.view.leadingAnchor,
                             bottomAnchor: self.view.bottomAnchor,
                             trailingAnchor: self.view.trailingAnchor,
                             padding: UIEdgeInsets(top: FilterCommon.Metric.detailViewTopMargin,
                                                   left: 0,
                                                   bottom: 0,
                                                   right: 0))
    }
  }
  
  private func removeFilterDetailView() {
    if let detailView = filterDetailView {
      for subView in detailView.subviews {
        subView.removeFromSuperview()
      }
    }
    filterDetailView?.removeFromSuperview()
  }
  
  private func isShowDetailView() -> Bool {
    return filterDetailView != nil && filterDetailView?.subviews.count ?? 0 > 0
  }
}
