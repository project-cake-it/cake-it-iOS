//
//  ColorFilterCell.swift
//  cake-it
//
//  Created by seungbong on 2021/04/13.
//

import UIKit

class ColorFilterCell: BaseFilterCell {
 
  @IBOutlet weak var colorView: UIView!
  @IBOutlet weak var colorLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    let view = Bundle.main.loadNibNamed(String(describing: ColorFilterCell.self),
                                        owner: self,
                                        options: nil)?.first as! UIView
    self.addSubview(view)
    
    colorView.layer.cornerRadius = colorView.frame.width/2
  }

  @IBAction func cellButtonDidTap(_ sender: Any) {
      super.cellDidTap()
  }
}
