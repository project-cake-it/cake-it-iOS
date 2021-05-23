//
//  FilterHeaderCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/21.
//

import UIKit

protocol FilterHeaderCellDelegate: class {
  func filterHeaderCellDidTap(type: FilterCommon.FilterType, isHighlighted: Bool)
}

final class FilterHeaderCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var arrowImageView: UIImageView!
  
  weak var delegate: FilterHeaderCellDelegate?
  private var flterType: FilterCommon.FilterType = .reset
  var isFilterHightlighted: Bool = false { // 필터에 현재 포커스가 가있는 상태
    didSet {
      if isFilterHightlighted == true {
        titleLabel.textColor = Colors.pointB
        arrowImageView.tintColor = Colors.pointB
        self.layer.borderColor = Colors.pointB.cgColor
      } else {
        titleLabel.textColor = Colors.black
        arrowImageView.tintColor = Colors.black
        self.layer.borderColor = Colors.grayscale03.cgColor
      }
      arrowImageView.isHighlighted = isFilterHightlighted
      
      if isSelected == true {
        delegate?.filterHeaderCellDidTap(type: flterType, isHighlighted: isFilterHightlighted)
      }
    }
  }
  var isFilterSelected: Bool = false {     // 필터 옵션이 지정된 상태
    didSet {
      if isFilterSelected == true {
        titleLabel.textColor = Colors.white
        arrowImageView.tintColor = Colors.white
        self.backgroundColor = Colors.pointB
      } else {
        titleLabel.textColor = Colors.black
        arrowImageView.tintColor = Colors.black
        self.backgroundColor = Colors.white
      }
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  func update(type: FilterCommon.FilterType, isSelected: Bool) {
    flterType = type
    isFilterSelected = isSelected
    
    titleLabel.text = type.korTitle
    arrowImageView.image = FilterCommon.titleIcon(type: type)
    arrowImageView.highlightedImage = FilterCommon.highlightedTitleIcon(type: type)
    self.clipsToBounds = false
    self.layer.borderWidth = 1
    self.layer.borderColor = Colors.grayscale03.cgColor
    self.layer.cornerRadius = self.frame.height/2
  }
}
