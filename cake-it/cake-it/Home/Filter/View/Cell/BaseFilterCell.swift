//
//  BaseFilterCell.swift
//  cake-it
//
//  Created by seungbong on 2021/04/15.
//

import UIKit

protocol BaseFilterCellDelegate {
  func cellDidTap(index: Int)
}

class BaseFilterCell: UIView {
  
  var filterIndex: Int? // 아~~이거 두개 생성자로 추가하고싶다아아ㅏㅏㅏㅏㅏ 어케하누
  var delegate: BaseFilterCellDelegate?

  func cellDidTap() {
    if let index = filterIndex {
      delegate?.cellDidTap(index: index)
    }
  }
}
