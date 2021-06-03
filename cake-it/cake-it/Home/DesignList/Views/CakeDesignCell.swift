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
    let imageUrlString = cakeDesign.designImages?.first?.designImageUrl ?? ""
    if let imageUrl = URL(string: imageUrlString) {
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: imageUrl) {
          DispatchQueue.main.async {
            self.cakeDesignImageView.image = UIImage(data: data)
          }
        }
      }
    }
    
    locationAndCakeSizeLabel.text = "\(cakeDesign.shopAddress) | \(cakeDesign.size)"
    nameLabel.text = cakeDesign.sizes?.first!.name
    priceLabel.text = String(cakeDesign.sizes?.first!.price ?? 0).moneyFormat.won
  }
}
