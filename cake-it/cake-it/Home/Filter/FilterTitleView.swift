//
//  FilterView.swift
//  cake-it
//
//  Created by seungbong on 2021/03/28.
//

import UIKit

protocol FilterTitleViewDelegate {
  func filterTitleButtonDidTap(index: Int)
}

class FilterTitleView: UIView {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  
  var delegate: FilterTitleViewDelegate?
  var filterList: [String] = [] {
    didSet {
      configureFilterButtonList()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    let view = Bundle.main.loadNibNamed(String(describing: FilterTitleView.self),
                                        owner: self,
                                        options: nil)?.first as! UIView
    
    self.addSubview(view)
  }
  
  private func configureFilterButtonList() {
    var xPos: CGFloat = 20.0
    var filterButtonList: [FilterButton] = []
    for i in 0..<filterList.count {
      let button = FilterButton(frame:CGRect(x: xPos, y: 0, width: 0, height: 0))
      button.delegate = self
      button.index = i
      button.setTitle(filterList[i], for: .normal)
      button.sizeToFit()
      filterButtonList.append(button)
      contentView.addSubview(button)
      xPos += button.frame.width + 10.0
    }
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    contentView.widthAnchor.constraint(equalToConstant: xPos).isActive = true
  }
  
}

extension FilterTitleView: FilterButtonDelegate {
  func filterButtonDidTap(_ sender: FilterButton) {
    delegate?.filterTitleButtonDidTap(index: sender.index)
  }
}
