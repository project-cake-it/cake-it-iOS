//
//  FilterDetailViewHeaderCell.swift
//  cake-it
//
//  Created by seungbong on 2021/05/25.
//

import UIKit

protocol FilterDetailViewHeaderCellDelegate: class {
  func headerCellDidTap(isSelected: Bool)
}

final class FilterDetailViewHeaderCell: UIView {
  
  @IBOutlet weak var checkImageView: UIImageView!
  weak var delegate: FilterDetailViewHeaderCellDelegate?
  
  var isCellSelected: Bool = false {
    didSet {
      checkImageView.isHidden = !isCellSelected
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
  
  private func commonInit(){
    let view = Bundle.main.loadNibNamed(String(describing: FilterDetailViewHeaderCell.self),
                                        owner: self,
                                        options: nil)?.first as! UIView
    self.addSubview(view)
  }
  
  @IBAction func buttonDidTap(_ sender: Any) {
    isCellSelected = !isCellSelected
    delegate?.headerCellDidTap(isSelected: isCellSelected)
  }
}
