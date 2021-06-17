//
//  FilterCategoryCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/21.
//

import UIKit

protocol FilterCategoryCellDelegate: AnyObject {
  func filterCategoryCellDidTap(type: FilterCommon.FilterType, isHighlightedCell: Bool)
}

final class FilterCategoryCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var arrowImageView: UIImageView!
  
  weak var delegate: FilterCategoryCellDelegate?
  private(set) var filterType: FilterCommon.FilterType = .reset
  var isFilterHightlighted: Bool = false { // 필터에 현재 포커스가 가있는 상태
    didSet {
      updateColorAndImage()
      
      if isSelected == true {
        delegate?.filterCategoryCellDidTap(type: filterType, isHighlightedCell: isFilterHightlighted)
      }
    }
  }
  var isFilterSelected: Bool = false {     // 필터 옵션이 지정된 상태
    didSet {
      updateColorAndImage()
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
    
    titleLabel.text = type.title
    self.clipsToBounds = false
    self.layer.borderWidth = 1
    self.layer.cornerRadius = self.frame.height/2
    
    updateColorAndImage()
  }
  
  private func updateColorAndImage() {
    if filterType == .reset {
      self.backgroundColor = Colors.white
      self.layer.borderColor = Colors.grayscale03.cgColor
      titleLabel.textColor = Colors.black
      arrowImageView.image = UIImage(named: "icReset")
      return
    }
    
    if isFilterHightlighted == true && isFilterSelected == true { // (T,T)
      arrowImageView.image = UIImage(named: "chevronCompactUpWhite")
      titleLabel.textColor = Colors.white
      self.layer.borderColor = Colors.pointB.cgColor
      self.backgroundColor = Colors.pointB
    } else if isFilterHightlighted == true && isFilterSelected == false {  // (T,F)
      arrowImageView.image = UIImage(named: "chevronCompactUp")
      titleLabel.textColor = Colors.pointB
      self.layer.borderColor = Colors.pointB.cgColor
      self.backgroundColor = Colors.white
    } else if isFilterHightlighted == false && isFilterSelected == true {  // (F,T)
      arrowImageView.image = UIImage(named: "chevronCompactDownWhite")
      titleLabel.textColor = Colors.white
      self.layer.borderColor = Colors.pointB.cgColor
      self.backgroundColor = Colors.pointB
    } else { // (F,F)
      arrowImageView.image = UIImage(named: "chevronCompactDown")
      titleLabel.textColor = Colors.black
      self.layer.borderColor = Colors.grayscale03.cgColor
      self.backgroundColor = Colors.white
    }
  }
}
