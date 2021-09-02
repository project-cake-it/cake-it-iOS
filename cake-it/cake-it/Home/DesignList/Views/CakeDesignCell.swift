//
//  CakeDesignCell.swift
//  cake-it
//
//  Created by Cory on 2021/03/25.
//

import UIKit
import Kingfisher

final class CakeDesignCell: UICollectionViewCell {
  
  @IBOutlet weak var cakeDesignImageView: UIImageView!
  @IBOutlet weak var locationAndCakeSizeLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    cakeDesignImageView.image = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configure()
  }
  
  func update(with cakeDesign: CakeDesign) {
    if let sizeInfo = cakeDesign.sizes.first {
      let sizeWithoutParentheses = sizeInfo.name.withoutParentheses()
      locationAndCakeSizeLabel.text = "\(cakeDesign.shopAddress) | \(sizeWithoutParentheses)"
      nameLabel.text = cakeDesign.name
      priceLabel.text = String(sizeInfo.price).moneyFormat.won
    }
    
    guard let imageInfo = cakeDesign.designImages.first,
          let cakeDesignImageURL = URL(string: imageInfo.designImageUrl) else {
      return
    }
    DispatchQueue.main.async {
      self.cakeDesignImageView.kf.setImage(with: cakeDesignImageURL,
                                           options: [.transition(.fade(0.35)), .forceTransition])
    }
  }
}

// MARK: - Configuration

extension CakeDesignCell {
  private func configure() {
    configureImageView()
  }
  
  private func configureImageView() {
    cakeDesignImageView.backgroundColor = Colors.grayscale02
  }
}
