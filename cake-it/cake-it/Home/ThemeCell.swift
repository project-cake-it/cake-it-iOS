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
        // Initialization code
    }
  
  func updateCell(isThemeCell:Bool, titleString:String) {
    if (isThemeCell) {
      backView.backgroundColor = Colors.grayscale02
      titleLabel.textColor = Colors.pointB
    } else {
      backView.backgroundColor = Colors.pointB
      titleLabel.textColor = Colors.white
    }
    
    titleLabel.text = titleString
  }

}
