//
//  FilterDescriptionCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/23.
//

import UIKit

class FilterDescriptionCell: BaseFilterCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var checkImageView: UIImageView!
  
  override var isCellSelected: Bool {
    didSet {
      checkImageView.isHidden = !isCellSelected
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
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
