//
//  FilterBasicCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/23.
//

import UIKit

class FilterBasicCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func update(title: String) {
    titleLabel.text = title
  }

}
