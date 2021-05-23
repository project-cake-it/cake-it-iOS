//
//  FilterBasicCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/23.
//

import UIKit

class FilterBasicCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var checkImageView: UIImageView!
  
  var isCellSelected: Bool = false {
    didSet {
      checkImageView.isHidden = !isCellSelected
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if isSelected == true {
      isCellSelected = !isCellSelected
    }
  }
  
  func update(title: String) {
    titleLabel.text = title
  }

}
