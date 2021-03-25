//
//  String_MoneyFormat.swift
//  cake-it
//
//  Created by Cory on 2021/03/25.
//

import Foundation

extension String {
  
  /// 숫자이고, 네자리수가 넘어가면 ,를 찍은 형태로 재반환합니다.
  var moneyFormat: String {
    guard let number = Int(self) else { return self }
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: number)) ?? self
  }
  
  /// 뒤에 원을 붙여 재반환합니다.
  var won: String {
    return self + "원"
  }
}
