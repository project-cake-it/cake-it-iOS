//
//  FilterTitleCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/21.
//

import UIKit

class FilterTitleCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var arrowImageView: UIImageView!
  @IBOutlet weak var cellButton: UIButton!
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  func update(title: String) {
    titleLabel.text = title
    cellButton.clipsToBounds = false
    cellButton.layer.borderWidth = 1
    cellButton.layer.borderColor = Colors.pointB.cgColor
    cellButton.layer.cornerRadius = cellButton.frame.height/2
  }
  
  @IBAction func cellDidTap(_ sender: Any) {
    arrowImageView.isHighlighted = !arrowImageView.isHighlighted
  }
}
