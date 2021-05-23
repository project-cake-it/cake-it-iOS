//
//  FilterTitleCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/21.
//

import UIKit

protocol FilterTitleCellDelegate {
  func filterTitleCellDidTap(type: FilterCommon.FilterType, isHighlighted: Bool)
}

final class FilterTitleCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var arrowImageView: UIImageView!
  @IBOutlet weak var cellButton: UIButton!
  var testVal: String = ""
  
  var delegate: FilterTitleCellDelegate?
  private var flterType: FilterCommon.FilterType = .reset
  var filterHightlighted: Bool = false { // 필터에 현재 포커스가 가있는 상태
    didSet {
      if filterHightlighted == true {
        titleLabel.textColor = Colors.pointB
        arrowImageView.tintColor = Colors.pointB
        self.layer.borderColor = Colors.pointB.cgColor
      } else {
        titleLabel.textColor = Colors.black
        arrowImageView.tintColor = Colors.black
        self.layer.borderColor = Colors.grayscale03.cgColor
      }
      arrowImageView.isHighlighted = filterHightlighted
      
      if isSelected == true {
        delegate?.filterTitleCellDidTap(type: flterType, isHighlighted: filterHightlighted)
      }
    }
  }
  var filterSelected: Bool = false {     // 필터 옵션이 지정된 상태
    didSet {
      if filterSelected == true {
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
  
  func update(type: FilterCommon.FilterType) {
    flterType = type
    titleLabel.text = type.korTitle
    arrowImageView.image = type.icon
    arrowImageView.highlightedImage = type.highLightIcon
    self.clipsToBounds = false
    self.layer.borderWidth = 1
    self.layer.borderColor = Colors.grayscale03.cgColor
    self.layer.cornerRadius = self.frame.height/2
  }
  
  @IBAction func cellDidTap(_ sender: Any) {
    filterHightlighted = !filterHightlighted
    
  }
}
