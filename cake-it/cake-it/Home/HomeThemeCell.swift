//
//  ThemeCell.swift
//  cake-it
//
//  Created by theodore on 2021/06/16.
//

import UIKit

final class HomeThemeCell: UICollectionViewCell {
  
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func updateCell(isMoreButton:Bool = false, title:String) {
    if isMoreButton {
      backView.backgroundColor = Colors.primaryColor
      titleLabel.textColor = Colors.white
    } else {
      backView.backgroundColor = Colors.grayscale02
      titleLabel.textColor = Colors.primaryColor
    }
    
    titleLabel.text = title
  }
}
