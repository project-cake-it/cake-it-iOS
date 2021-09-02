//
//  UIView+AutoLayout.swift
//  cake-it
//
//  Created by Cory on 2021/03/26.
//

import UIKit

extension UIView {
  /// superView에 top, leading, trailing, bottom anchor를 동일하게 하여 꽉 채우게 하는 함수입니다.
  func fillSuperView() {
    guard let superView = self.superview else { return }
    self.translatesAutoresizingMaskIntoConstraints = false
    self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
    self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
    self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
  }
  
  func constraints(topAnchor: NSLayoutYAxisAnchor?,
                   leadingAnchor: NSLayoutXAxisAnchor?,
                   bottomAnchor: NSLayoutYAxisAnchor?,
                   trailingAnchor: NSLayoutXAxisAnchor?,
                   padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
    self.translatesAutoresizingMaskIntoConstraints = false
    
    if let topAnchor = topAnchor {
      self.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
    }
    if let leadingAnchor = leadingAnchor {
      self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
    }
    if let bottomAnchor = bottomAnchor {
      self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom).isActive = true
    }
    if let trailingAnchor = trailingAnchor {
      self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
    }
    if size.width != 0 {
      self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    if size.height != 0 {
      self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
  }
  
  func constraints(topAnchor: NSLayoutYAxisAnchor? = nil,
                   leadingAnchor: NSLayoutXAxisAnchor? = nil,
                   bottomAnchor: NSLayoutYAxisAnchor? = nil,
                   trailingAnchor: NSLayoutXAxisAnchor? = nil,
                   centerXAnchor: NSLayoutXAxisAnchor? = nil,
                   centerYAnchor: NSLayoutYAxisAnchor? = nil,
                   padding: UIEdgeInsets = .zero,
                   width: CGFloat? = .zero,
                   height: CGFloat? = .zero) {
    self.translatesAutoresizingMaskIntoConstraints = false
    
    if let topAnchor = topAnchor {
      self.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
    }
    if let leadingAnchor = leadingAnchor {
      self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
    }
    if let bottomAnchor = bottomAnchor {
      self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom).isActive = true
    }
    if let trailingAnchor = trailingAnchor {
      self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
    }
    if let centerXAnchor = centerXAnchor {
      self.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    if let centerYAnchor = centerYAnchor {
      self.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    if let width = width, width != 0 {
      self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if let height = height, height != 0 {
      self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  /// superView 중앙에 바로 위치 시키는 함수입니다.
  func centerInSuperView(constantX: CGFloat = 0, constantY: CGFloat = 0) {
    guard let superView = self.superview else { return }
    self.translatesAutoresizingMaskIntoConstraints = false
    self.centerXAnchor.constraint(
      equalTo: superView.centerXAnchor,
      constant: constantX).isActive = true
    self.centerYAnchor.constraint(
      equalTo: superView.centerYAnchor,
      constant: constantY).isActive = true
  }
}
