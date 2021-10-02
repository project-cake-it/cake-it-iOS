//
//  SelectedFilterOptionCell.swift
//  cake-it
//
//  Created by Cory on 2021/10/02.
//

import UIKit

protocol SelectedFilterOptionCellDelegate: AnyObject {
  func selectedFilterOptionCell(closeButtonDidTap fromCell: SelectedFilterOptionCell)
}

final class SelectedFilterOptionCell: UICollectionViewCell {
  
  @IBOutlet var filterOptionContainerView: UIView!
  @IBOutlet var filterOptionTitleLabel: UILabel!
  
  weak var delegate: SelectedFilterOptionCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configure()
  }
  
  func update(with title: String?) {
    filterOptionTitleLabel.text = title
  }
  
  @IBAction func closeButtonDidTap(_ sender: Any) {
    delegate?.selectedFilterOptionCell(closeButtonDidTap: self)
  }
}

// MARK: - Configuration

extension SelectedFilterOptionCell {
  private func configure() {
    configureViews()
  }
  
  private func configureViews() {
    filterOptionContainerView.round(cornerRadius: 7)
  }
}
