//
//  FilterTableHeaderCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/26.
//

import UIKit

protocol FilterTableHeaderCellDelegate: class {
  func headerCellDidTap(isSelected: Bool)
}

class FilterTableHeaderCell: UITableViewCell {
  
  @IBOutlet weak var checkImageView: UIImageView!
  
  weak var delegate: FilterTableHeaderCellDelegate?
  var isCellSelected: Bool = false {
    didSet {
      checkImageView.isHidden = !isCellSelected
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func buttonDidTap(_ sender: Any) {
    isCellSelected = !isCellSelected
    delegate?.headerCellDidTap(isSelected: isCellSelected)
  }
}
