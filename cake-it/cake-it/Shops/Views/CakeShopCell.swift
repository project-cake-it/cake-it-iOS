//
//  CakeShopCell.swift
//  cake-it
//
//  Created by Cory on 2021/04/06.
//

import UIKit

final class CakeShopCell: UICollectionViewCell {
  
  @IBOutlet weak var shopImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var tagStackView: UIStackView!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    shopImageView.image = nil
    
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configure()
  }
  
  func update(with cakeShop: CakeShop) {
    let cakeShopImageURL = URL(string: cakeShop.image)
    DispatchQueue.global().async {
      let data = try? Data(contentsOf: cakeShopImageURL!)
      DispatchQueue.main.async {
        self.shopImageView.image = UIImage(data: data!)
      }
    }
    nameLabel.text = cakeShop.name
    addressLabel.text = cakeShop.address
  }
}

extension CakeShopCell {
  private func configure() {
    
  }
}
