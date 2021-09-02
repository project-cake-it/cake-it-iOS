//
//  UILabel+LineSpacing.swift
//  cake-it
//
//  Created by Cory on 2021/09/03.
//

import UIKit

extension UILabel {
  /// UILabel의 줄 간격을 설정할 수 있습니다.
  /// - Parameter lineSpacing: 14pt 폰트에서 4.4가 적당합니다.
  func setLineSpacing(_ lineSpacing: CGFloat) {
    let attributedString = NSMutableAttributedString(string: self.text ?? "")
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    attributedString.addAttribute(
      NSAttributedString.Key.paragraphStyle,
      value:paragraphStyle,
      range:NSMakeRange(0, attributedString.length))
    self.attributedText = attributedString
  }
}
