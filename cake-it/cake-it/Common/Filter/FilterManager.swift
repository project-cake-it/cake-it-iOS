//
//  FilterManager.swift
//  cake-it
//
//  Created by seungbong on 2021/05/30.
//

import Foundation

final class FilterManager {
  
  static let shared = FilterManager()

  func numberOfCase(type: FilterCommon.FilterType) -> Int {
    switch type {
    case .reset:    return 0
    case .order:    return FilterCommon.FilterSorting.allCases.count
    case .region:   return FilterCommon.FilterRegion.allCases.count
    case .size:     return FilterCommon.FilterSize.allCases.count
    case .color:    return FilterCommon.FilterColor.allCases.count
    case .category: return FilterCommon.FilterCategory.allCases.count
    default:        return 0
    }
  }
  
  func allValuesOfCase(type: FilterCommon.FilterType) -> [String] {
    switch type {
    case .reset:    return []
    case .order:    return FilterCommon.FilterSorting.allCases.map { $0.value }
    case .region:   return FilterCommon.FilterRegion.allCases.map { $0.value }
    case .size:     return FilterCommon.FilterSize.allCases.map { $0.value }
    case .color:    return FilterCommon.FilterColor.allCases.map { $0.value }
    case .category: return FilterCommon.FilterCategory.allCases.map { $0.value }
    default:        return []
    }
  }
  
  func isMultiSelectionEnabled(type: FilterCommon.FilterType) -> Bool {
    switch type {
    case .reset:      return false
    case .order:      return false
    case .region:     return true
    case .size:       return true
    case .color:      return true
    case .category:   return true
    case .pickupDate: return false
    default:          return false
    }
  }
  
  
  /// Filter Value와 Filter Type이 주어졌을 때 Filter Title을 반환하는 함수
  /// ex. "byPriceLow" -> "가격 낮은 순"
  private func replaceToTitle(from filterValue: String,
                              filterType: FilterCommon.FilterType) -> String? {
    switch filterType {
    case .reset:
      return nil
    case .order:
      let sortingFilter = FilterCommon.FilterSorting(rawValue: filterValue)
      return sortingFilter?.title
    case .region:
      let regionFilter = FilterCommon.FilterRegion(rawValue: filterValue)
      return regionFilter?.title
    case .size:
      let sizeFilter = FilterCommon.FilterSize(rawValue: filterValue)
      return sizeFilter?.title
    case .color:
      let colorFilter = FilterCommon.FilterColor(rawValue: filterValue)
      return colorFilter?.title
    case .category:
      let categoryFilter = FilterCommon.FilterCategory(rawValue: filterValue)
      return categoryFilter?.title
    default:
      return nil
    }
  }
  
  /// 필터 타이틀로 어떤 것을 보여줄지 결정하는 함수.
  ///
  /// - Parameters:
  ///   - isSelected: 필터 선택 여부
  ///   - filterType: 필터 타입
  ///   - filterValues: 선택된 필터 값
  /// - Returns: 화면에 보여줄 타이틀
  func filterTitle(isSelected: Bool,
                   filterType: FilterCommon.FilterType,
                   filterValues: [String]) -> String? {
    if isSelected == false {
      return filterType.title
    }
    
    if filterType == .order {
      if let value = filterValues.first {
        if let title = replaceToTitle(from: value,
                                      filterType: filterType) {
          return title
        }
      }
    }
    
    return filterType.title
  }
}
