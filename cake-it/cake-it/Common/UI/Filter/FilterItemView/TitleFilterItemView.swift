//
//  TitleFilterItemView.swift
//  cake-it
//
//  Created by seungbong on 2021/04/13.
//

import UIKit

final class TitleFilterItemView: BaseFilterItemView {

  @IBOutlet weak var label: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    let view = Bundle.main.loadNibNamed(String(describing: TitleFilterItemView.self),
                                        owner: self,
                                        options: nil)?.first as! UIView
    self.addSubview(view)
  }

  @IBAction func cellButtonDidTap(_ sender: Any) {
      super.cellDidTap()
  }
}
