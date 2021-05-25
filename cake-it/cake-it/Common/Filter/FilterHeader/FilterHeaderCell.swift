//
//  FilterHeaderCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/21.
//

import UIKit

protocol FilterHeaderCellDelegate: class {
  func filterHeaderCellDidTap(type: FilterCommon.FilterType, isHighlightedCell: Bool)
}

final class FilterHeaderCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var arrowImageView: UIImageView!
  
  weak var delegate: FilterHeaderCellDelegate?
  private(set) var filterType: FilterCommon.FilterType = .reset
  var isFilterHightlighted: Bool = false { // 필터에 현재 포커스가 가있는 상태
    didSet {
      changeViewColor()
      
      if isSelected == true {
        delegate?.filterHeaderCellDidTap(type: filterType, isHighlightedCell: isFilterHightlighted)
      }
    }
  }
  var isFilterSelected: Bool = false {     // 필터 옵션이 지정된 상태
    didSet {
      changeViewColor()
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    isFilterHightlighted = false
    isFilterSelected = false
  }
  
  func update(type: FilterCommon.FilterType, isHighlighted: Bool, isSelected: Bool) {
    filterType = type
    isFilterHightlighted = isHighlighted
    isFilterSelected = isSelected
    
    titleLabel.text = type.korTitle
    arrowImageView.image = FilterCommon.headerIcon(type: type)
    self.clipsToBounds = false
    self.layer.borderWidth = 1
    self.layer.cornerRadius = self.frame.height/2
    
    changeViewColor()
  }
  
  private func changeViewColor() {
    if isFilterHightlighted == true && isFilterSelected == true { // (T,T)
      self.backgroundColor = Colors.pointB
      self.layer.borderColor = Colors.pointB.cgColor
      titleLabel.textColor = Colors.white
      arrowImageView.image = UIImage(named: "chevronCompactUpWhite")
    } else if isFilterHightlighted == true && isFilterSelected == false {  // (T,F)
      self.backgroundColor = Colors.white
      self.layer.borderColor = Colors.pointB.cgColor
      titleLabel.textColor = Colors.pointB
      arrowImageView.image = UIImage(named: "chevronCompactUp")
    } else if isFilterHightlighted == false && isFilterSelected == true {  // (F,T)
      self.backgroundColor = Colors.pointB
      self.layer.borderColor = Colors.pointB.cgColor
      titleLabel.textColor = Colors.white
      arrowImageView.image = UIImage(named: "chevronCompactDownWhite")
    } else { // (F,F)
      self.backgroundColor = Colors.white
      self.layer.borderColor = Colors.grayscale03.cgColor
      titleLabel.textColor = Colors.black
      arrowImageView.image = UIImage(named: "chevronCompactDown")
    }
  }
}
