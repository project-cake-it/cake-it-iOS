//
//  BaseFilterCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/23.
//

import UIKit

class BaseFilterCell: UITableViewCell {

  var isCellSelected: Bool = false
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
