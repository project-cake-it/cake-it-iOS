//
//  FilterTableHeaderCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/26.
//

import UIKit

protocol FilterTableHeaderCellDelegate: AnyObject {
  func headerCellDidTap(isSelected: Bool)
}

final class FilterTableHeaderCell: UITableViewCell {
  
  @IBOutlet weak var checkImageView: UIImageView!
  
  weak var delegate: FilterTableHeaderCellDelegate?
  var isCellSelected: Bool = false {
    didSet {
      checkImageView.isHidden = !isCellSelected
    }
  }
  
  @IBAction func buttonDidTap(_ sender: Any) {
    isCellSelected = !isCellSelected
    delegate?.headerCellDidTap(isSelected: isCellSelected)
  }
}
