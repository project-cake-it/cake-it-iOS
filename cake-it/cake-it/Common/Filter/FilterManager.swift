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
    case .order:    return FilterCommon.FilterSorting.allCases.map { $0.title }
    case .region:   return FilterCommon.FilterRegion.allCases.map { $0.title }
    case .size:     return FilterCommon.FilterSize.allCases.map { $0.title }
    case .color:    return FilterCommon.FilterColor.allCases.map { $0.title }
    case .category: return FilterCommon.FilterCategory.allCases.map { $0.title }
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
}
