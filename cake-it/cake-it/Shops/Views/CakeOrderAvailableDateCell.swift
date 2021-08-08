//
//  CakeOrderAvailableDateCell.swift
//  cake-it
//
//  Created by Cory on 2021/08/08.
//

import UIKit

final class CakeOrderAvailableDateCell: UICollectionViewCell {
  
  @IBOutlet var dayLabel: UILabel!
  @IBOutlet var todayCircleView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    todayCircleView.round(cornerRadius: 3)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    todayCircleView.isHidden = true
    dayLabel.textColor = Colors.grayscale03
  }
  
  func update(with date: CakeOrderAvailableDate) {
    guard !date.isEmpty else {
      dayLabel.text = ""
      return
    }
    dayLabel.text = String(date.day)
    dayLabel.textColor = date.isEnabled ? UIColor.black : Colors.grayscale03
    todayCircleView.isHidden = !((Date().day == date.day) && (Date().month == date.month))
  }
}
