//
//  CakeOrderAvailableDates.swift
//  cake-it
//
//  Created by Cory on 2021/08/08.
//

import Foundation

struct CakeOrderAvailableDates {
  private var dates: [CakeOrderAvailableDate]
  
  var count: Int {
    return dates.count
  }
  
  var last: CakeOrderAvailableDate? {
    return dates.last
  }
  
  init(dates: [CakeOrderAvailableDate] = []) {
    self.dates = dates
  }
  
  mutating func configureFirstDayOffsetDates() {
    removeEmptyDates()
    let firstDayDate = dates.first!
    let firstDayOffset = firstDayDate.date.weekday - 1
    for _ in 0..<firstDayOffset {
      var emptyDate = CakeOrderAvailableDate(date: Date())
      emptyDate.setEmpty()
      self.dates.insert(emptyDate, at: 0)
    }
  }
  
  mutating func append(_ reservationDate: CakeOrderAvailableDate) {
    dates.append(reservationDate)
  }
  
  mutating func removeEmptyDates() {
    dates = dates.filter{ !$0.isEmpty }
  }
  
  subscript(index: Int) -> CakeOrderAvailableDate {
    get {
      dates[index]
    }
    set(newValue) {
      dates[index] = newValue
    }
  }
}
