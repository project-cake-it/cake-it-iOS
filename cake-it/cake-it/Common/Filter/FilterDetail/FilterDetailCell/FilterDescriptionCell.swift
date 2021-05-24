//
//  FilterDescriptionCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/23.
//

import UIKit

class FilterDescriptionCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var checkImageView: UIImageView!
  
  var isCellSelected: Bool = false {
    didSet {
      checkImageView.isHidden = !isCellSelected
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func prepareForReuse() {
    isCellSelected = false
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if isSelected == true {
      isCellSelected = !isCellSelected
    }
  }
  

  func update(title: String, description: String) {
    titleLabel.text = title
    descriptionLabel.text = description
  }
}

