//
//  BaseFilterCell.swift
//  cake-it
//
//  Created by seungbong on 2021/04/15.
//

import UIKit

protocol BaseFilterCellDelegate: class {
  func cellDidTap(index: Int)
}

class BaseFilterCell: UIView {
  
  var filterIndex: Int?
  weak var delegate: BaseFilterCellDelegate?

  func cellDidTap() {
    if let index = filterIndex {
      delegate?.cellDidTap(index: index)
    }
  }
}
