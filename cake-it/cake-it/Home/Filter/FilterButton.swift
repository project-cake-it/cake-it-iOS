//
//  FilterButton.swift
//  cake-it
//
//  Created by seungbong on 2021/03/28.
//

import UIKit

protocol FilterButtonDelegate {
  func filterButtonDidTap(_ sender: FilterButton)
}

class FilterButton: UIButton {

  var delegate: FilterButtonDelegate?
  var index: Int = 0    // filter type을 구분할 버튼 인덱스
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    self.setTitleColor(Colors.pointB, for: .normal)
    self.backgroundColor = Colors.white
    self.clipsToBounds = true
    self.layer.borderWidth = 1.0
    self.layer.borderColor = Colors.pointB.cgColor
    self.round(cornerRadius: 15.0)
    self.contentEdgeInsets = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10) // padding 설정
    self.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
  }
  
  @objc private func buttonDidTap(_ sender: FilterButton) {
    delegate?.filterButtonDidTap(sender)
  }
  
}
