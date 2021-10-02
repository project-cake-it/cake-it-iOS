//
//  MyPageCell.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

final class MyPageCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet var versionLabel: UILabel!
  @IBOutlet var rightIcon: UIImageView!
  
  func updateCell(title: String) {
    titleLabel.text = title
    
    if title == Constants.CELL_TITLE_VERSION_INFO {
      versionLabel.isHidden = false
      rightIcon.isHidden = true
      versionLabel.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    } else if (title == Constants.CELL_TITLE_LOGIN ||
               title == Constants.CELL_TITLE_LOGINOUT) {
      rightIcon.isHidden = true
    } else {
      versionLabel.isHidden = true
      rightIcon.isHidden = false
    }
  }
}
