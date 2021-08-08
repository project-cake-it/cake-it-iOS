//
//  DateFormatter+CakeOrderAvailableDateFormatter.swift
//  cake-it
//
//  Created by Cory on 2021/08/08.
//

import Foundation

extension DateFormatter {
  static let CakeOrderAvailableDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    formatter.timeZone = TimeZone(secondsFromGMT: 9 * 60 * 60)!
    formatter.calendar = Calendar(identifier: .iso8601)
    return formatter
  }()
}
