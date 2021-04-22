//
//  BaseFilterItemView.swift
//  cake-it
//
//  Created by seungbong on 2021/04/15.
//

import UIKit

protocol BaseFilterItemViewDelegate: class {
  func cellDidTap(index: Int)
}

class BaseFilterItemView: UIView {
  
  var filterIndex: Int?
  weak var delegate: BaseFilterItemViewDelegate?

  func cellDidTap() {
    if let index = filterIndex {
      delegate?.cellDidTap(index: index)
    }
  }
}
