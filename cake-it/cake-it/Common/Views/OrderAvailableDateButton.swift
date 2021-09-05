//
//  OrderAvailableDateButton.swift
//  cake-it
//
//  Created by Cory on 2021/09/03.
//

import UIKit

final class OrderAvailableDateButton: UIButton {
  
  init() {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? Colors.primaryColor05 : Colors.white
    }
  }
}
