//
//  LoadingBlockView.swift
//  cake-it
//
//  Created by Cory on 2021/09/05.
//

import UIKit

final class LoadingBlockView: UIView {
  
  let activityIndicatorView = UIActivityIndicatorView(style: .medium)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
}

// MARK: - Configuration

extension LoadingBlockView {
  private func configure() {
    backgroundColor = Colors.white
    activityIndicatorView.color = Colors.primaryColor02
    addSubview(activityIndicatorView)
    activityIndicatorView.startAnimating()
    activityIndicatorView.centerInSuperView()
  }
}
