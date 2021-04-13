//
//  DescriptionFilterCell.swift
//  cake-it
//
//  Created by seungbong on 2021/04/13.
//

import UIKit

class DescriptionFilterCell: UIView {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    let view = Bundle.main.loadNibNamed(String(describing: DescriptionFilterCell.self),
                                        owner: self,
                                        options: nil)?.first as! UIView
    self.addSubview(view)
  }


}
