//
//  CakeDesignCell.swift
//  cake-it
//
//  Created by Cory on 2021/03/25.
//

import UIKit

final class CakeDesignCell: UICollectionViewCell {
  
  @IBOutlet weak var cakeDesignImageView: UIImageView!
  @IBOutlet weak var locationAndCakeSizeLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    cakeDesignImageView.image = nil
    locationAndCakeSizeLabel.text = nil
    nameLabel.text = nil
    priceLabel.text = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func update(with cakeDesign: CakeDesign) {
    if let sizeInfo = cakeDesign.sizes.first {
      let removedBracketSizeName = sizeInfo.name.removeBracketInSizeInfo()
      locationAndCakeSizeLabel.text = "\(cakeDesign.shopAddress) | \(removedBracketSizeName)"
      nameLabel.text = cakeDesign.name
      priceLabel.text = String(sizeInfo.price).moneyFormat.won
    }
    
    guard let imageInfo = cakeDesign.designImages.first,
          let cakeDesignImageURL = URL(string: imageInfo.designImageUrl) else {
      return
    }
    DispatchQueue.global().async {
      if let imageData = try? Data(contentsOf: cakeDesignImageURL) {
        DispatchQueue.main.async {
          self.cakeDesignImageView.image = UIImage(data: imageData)
        }
      }
    }
  }
}
