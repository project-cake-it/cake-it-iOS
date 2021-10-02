//
//  SelectedFilterOption.swift
//  cake-it
//
//  Created by Cory on 2021/10/02.
//

import Foundation

struct SelectedFilterOption {
  let key: String
  let value: String
  
  func title() -> String? {
    var title: String? = nil
    switch key {
    case "order":
      FilterCommon.FilterSorting.allCases.forEach {
        if value == $0.value {
          title = $0.title
        }
      }
    case "size":
      FilterCommon.FilterSize.allCases.forEach {
        if value == $0.value {
          title = $0.title
        }
      }
    case "color":
      FilterCommon.FilterColor.allCases.forEach {
        if value == $0.value {
          title = $0.title
        }
      }
    case "category":
      FilterCommon.FilterCategory.allCases.forEach {
        if value == $0.value {
          title = $0.title
        }
      }
    case "location":
      return value
    case "pickup":
      guard let date = DateFormatter.CakeOrderAvailableDateFormatter.date(from: value) else { return nil}
      title = "\(date.month)월 \(date.day)일"
    default:
      break
    }
    return title
  }
}
