//
//  FilterColorCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/23.
//

import UIKit

class FilterColorCell: UITableViewCell {

  @IBOutlet weak var colorLabel: UILabel!
  @IBOutlet weak var colorView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func update(title: String, color: UIColor) {
    colorLabel.text = title
    colorView.backgroundColor = color
  }
}
