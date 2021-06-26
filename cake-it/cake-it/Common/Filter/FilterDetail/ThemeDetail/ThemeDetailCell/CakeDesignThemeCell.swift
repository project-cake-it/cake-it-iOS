//
//  ThemeCellTableViewCell.swift
//  cake-it
//
//  Created by seungbong on 2021/06/20.
//

import UIKit

final class CakeDesignThemeCell: UITableViewCell {
  
  @IBOutlet weak var themeLabel: UILabel!
  
  override func prepareForReuse() {
    themeLabel.textColor = Colors.black
    themeLabel.font = Fonts.spoqaHanSans(weight: .Regular, size: 14.0)
  }
}
