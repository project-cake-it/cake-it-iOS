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
  @IBOutlet weak var checkImageView: UIImageView!
  
  var isCellSelected: Bool = false {
    didSet {
      checkImageView.isHidden = !isCellSelected
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    initUI()
  }
  
  private func initUI() {
    colorView.layer.cornerRadius = colorView.frame.width/2
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if isSelected == true {
      isCellSelected = !isCellSelected
    }
  }
  
  func update(title: String, color: UIColor) {
    colorLabel.text = title
    colorView.backgroundColor = color
  }
}
