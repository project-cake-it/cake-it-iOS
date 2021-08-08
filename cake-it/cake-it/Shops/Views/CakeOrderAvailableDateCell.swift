//
//  CakeOrderAvailableDateCell.swift
//  cake-it
//
//  Created by Cory on 2021/08/08.
//

import UIKit

final class CakeOrderAvailableDateCell: UICollectionViewCell {
  
  @IBOutlet var dayLabel: UILabel!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    dayLabel.textColor = Colors.grayscale03
  }
  
  func update(with date: CakeOrderAvailableDate) {
    guard !date.isEmpty else {
      dayLabel.text = ""
      return
    }
    dayLabel.text = String(date.day)
    dayLabel.textColor = date.isEnabled ? UIColor.black : Colors.grayscale03
  }
}
