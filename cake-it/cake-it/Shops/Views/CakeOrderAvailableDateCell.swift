//
//  CakeOrderAvailableDateCell.swift
//  cake-it
//
//  Created by Cory on 2021/08/08.
//

import UIKit

final class CakeOrderAvailableDateCell: UICollectionViewCell {
  
  static let heightForPickUpDateCell: CGFloat = 44.0
  
  @IBOutlet var dayLabel: UILabel!
  @IBOutlet var todayCircleView: UIView!
  @IBOutlet var selectionCircleView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configure()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    selectionCircleView.isHidden = true
    todayCircleView.isHidden = true
    dayLabel.textColor = Colors.grayscale03
  }
  
  func update(with date: CakeOrderAvailableDate) {
    guard date.isEmpty == false else {
      dayLabel.text = ""
      return
    }
    dayLabel.text = String(date.day)
    dayLabel.textColor = date.isEnabled ? UIColor.black : Colors.grayscale03
    todayCircleView.isHidden = !((Date().day == date.day) && (Date().month == date.month))
  }
  
  func selected() {
    selectionCircleView.isHidden = false
    dayLabel.textColor = Colors.white
  }
  
  func deselected() {
    selectionCircleView.isHidden = true
    dayLabel.textColor = Colors.black
  }
}

// MARK: - Configuration

extension CakeOrderAvailableDateCell {
  private func configure() {
    configureViews()
  }
  
  private func configureViews() {
    layoutIfNeeded()
    todayCircleView.round(cornerRadius: 3)
    selectionCircleView.round(cornerRadius: (Self.heightForPickUpDateCell - 4) / 2)
    selectionCircleView.isHidden = true
  }
}
