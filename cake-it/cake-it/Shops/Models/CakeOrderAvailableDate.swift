//
//  CakeOrderAvailableDate.swift
//  cake-it
//
//  Created by Cory on 2021/08/08.
//

import Foundation

struct CakeOrderAvailableDate {
  private(set) var year: Int
  private(set) var month: Int
  private(set) var day: Int
  private(set) var hour: Int
  private(set) var isEmpty: Bool = false
  private(set) var isEnabled: Bool = false
  
  init(year: Int, month: Int, day: Int, hour: Int = 0) {
    self.year = year
    self.month = month
    self.day = day
    self.hour = hour
  }
  
  init(date: Date) {
    var calendar = Calendar(identifier: .iso8601)
    calendar.timeZone = TimeZone(secondsFromGMT: 9 * 60 * 60)!
    let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
    year = components.year ?? 0
    month = components.month ?? 0
    day = components.day ?? 0
    hour = components.hour ?? 0
  }
  
  var date: Date {
    let dateString = "\(year)\(String(format: "%02d", month))\(String(format: "%02d", day))"
    return DateFormatter.CakeOrderAvailableDateFormatter.date(from: dateString)!
  }
  
  /// offset만큼의 이후의 월의 date를 반환하는 함수입니다. 월에 offset 값을 더하며, 12가 넘어가면 year를 하나 올려주며 day는 전혀 터치하지 않습니다.
  /// - Parameter monthOffset: 더하고 싶은 월의 값
  func after(monthOffset: Int) -> Self {
    var year = self.year
    var month = self.month + monthOffset
    if month > 12 {
      year += 1
      month -= 12
    }
    return CakeOrderAvailableDate(year: year, month: month, day: self.day)
  }
  
  func after(dayOffset: Int) -> Self {
    var calendar = Calendar(identifier: .iso8601)
    calendar.timeZone = TimeZone(secondsFromGMT: 9 * 60 * 60)!
    
    let day = DateComponents(day: dayOffset)
    let afterDay = calendar.date(byAdding: day, to: date)!
    return CakeOrderAvailableDate(
      year: afterDay.year,
      month: afterDay.month,
      day: afterDay.day)
  }
  
  mutating func disabled() {
    isEnabled = false
  }
  
  mutating func enabled() {
    isEnabled = true
  }
  
  mutating func setEmpty() {
    isEmpty = true
    isEnabled = false
  }
}

extension CakeOrderAvailableDate: Comparable {
  static func < (lhs: CakeOrderAvailableDate, rhs: CakeOrderAvailableDate) -> Bool {
    return lhs.date < rhs.date
  }
  
  static func == (lhs: CakeOrderAvailableDate, rhs: CakeOrderAvailableDate) -> Bool {
    return lhs.date == rhs.date
  }
}
