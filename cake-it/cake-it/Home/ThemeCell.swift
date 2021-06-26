//
//  ThemeCell.swift
//  cake-it
//
//  Created by theodore on 2021/06/16.
//

import UIKit

final class ThemeCell: UICollectionViewCell {
  
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func updateCell(isMoreButton:Bool = false, title:String) {
    if isMoreButton {
      backView.backgroundColor = Colors.pointB
      titleLabel.textColor = Colors.white
    } else {
      backView.backgroundColor = Colors.grayscale02
      titleLabel.textColor = Colors.pointB
    }
    
    titleLabel.text = title
  }
}
