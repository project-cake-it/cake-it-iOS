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
  @IBOutlet weak var miniSizeCakePriceLabel: UILabel!
  @IBOutlet weak var levelOneSizeCakePriceLabel: UILabel!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    shopImageView.image = nil
    tagStackView.removeAllArrangedSubviews()
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
    miniSizeCakePriceLabel.text = String(cakeShop.miniSizeCakePrice).moneyFormat.won
    levelOneSizeCakePriceLabel.text = String(cakeShop.levelOneSizeCakePrice).moneyFormat.won
    updateTagStackView(tags: cakeShop.tags)
  }
  
  private func updateTagStackView(tags: [String]) {
    tags.forEach {
      let tagLabel = PaddingLabel()
      tagLabel.layer.borderColor = Colors.grayscale02.cgColor
      tagLabel.layer.borderWidth = 1.0
      tagLabel.text = "#" + $0
      tagLabel.textColor = Colors.grayscale04
      tagLabel.font = Fonts.spoqaHanSans(weight: .Regular, size: 11.0)
      tagLabel.backgroundColor = .clear
      tagLabel.insets = .init(top: 0, left: 4, bottom: 0, right: 4)
      tagStackView.addArrangedSubview(tagLabel)
    }
  }
}
