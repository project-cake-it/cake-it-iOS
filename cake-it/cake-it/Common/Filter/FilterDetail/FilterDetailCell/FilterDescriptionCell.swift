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
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func update(title: String, description: String) {
    titleLabel.text = title
    descriptionLabel.text = description
  }
}

