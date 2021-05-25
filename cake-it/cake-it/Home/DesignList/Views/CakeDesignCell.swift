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
    let cakeDesignImageURL = URL(string: cakeDesign.image)
    DispatchQueue.global().async {
      let data = try? Data(contentsOf: cakeDesignImageURL!)
      DispatchQueue.main.async {
        self.cakeDesignImageView.image = UIImage(data: data!)
      }
    }
    locationAndCakeSizeLabel.text = "\(cakeDesign.location) | \(cakeDesign.size)"
    nameLabel.text = cakeDesign.name
    priceLabel.text = String(cakeDesign.price).moneyFormat.won
  }
}
