//
//  ContactToShopButton.swift
//  cake-it
//
//  Created by Cory on 2021/05/19.
//

import UIKit

final class ContactToShopButton: UIButton {
  
  enum State {
    case floating
    case hidden
  }
  
  var displayState: State = .floating
  
  @IBOutlet var contentView: UIView!
  
  init() {
    super.init(frame: .zero)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
}

// MARK: - Configuration

extension ContactToShopButton {
  private func configure() {
    configureNib()
    configureUserInteractionEnabled()
    configureViews()
  }
  
  private func configureNib() {
    Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.addSubview(contentView)
  }
  
  private func configureUserInteractionEnabled() {
    contentView.isUserInteractionEnabled = false
  }
  
  private func configureViews() {
    round(cornerRadius: 8.0, clipsToBounds: true)
  }
}
