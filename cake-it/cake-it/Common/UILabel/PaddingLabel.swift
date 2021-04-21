//
//  PaddingLabel.swift
//  cake-it
//
//  Created by Cory on 2021/04/18.
//

import UIKit

final class PaddingLabel: UILabel {
  
  @IBInspectable var topInset: CGFloat = 0.0
  @IBInspectable var bottomInset: CGFloat = 0.0
  @IBInspectable var leftInset: CGFloat = 0.0
  @IBInspectable var rightInset: CGFloat = 0.0
  
  var insets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0) {
    didSet {
      topInset = insets.top
      leftInset = insets.left
      bottomInset = insets.bottom
      rightInset = insets.right
    }
  }
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset,
                              left: leftInset,
                              bottom: bottomInset,
                              right: rightInset)
    super.drawText(in: rect.inset(by: insets))
  }
  
  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset,
                  height: size.height + topInset + bottomInset)
  }
  
  override var bounds: CGRect {
    didSet {
      preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
    }
  }
}
