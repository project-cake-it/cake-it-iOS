//
//  CakeShopCell.swift
//  cake-it
//
//  Created by Cory on 2021/04/06.
//

import UIKit
import Kingfisher

final class CakeShopCell: UICollectionViewCell {
  
  @IBOutlet weak var shopImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var tagStackView: UIStackView!
  @IBOutlet weak var miniSizeCakePriceLabel: UILabel!
  @IBOutlet weak var levelOneSizeCakePriceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configure()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    shopImageView.image = nil
    tagStackView.removeAllArrangedSubviews()
  }
  
  func update(with cakeShop: CakeShop) {
    updateShopImage(imageURL: cakeShop.shopImages.first?.shopImageURL)
    nameLabel.text = cakeShop.name
    addressLabel.text = cakeShop.address
    updateCakePrice(by: cakeShop.sizes)
    updateTagStackView(tags: cakeShop.hashtags.map { $0.name })
  }
  
  private func updateShopImage(imageURL: String?) {
    if let imageURL = imageURL {
      let cakeShopImageURL = URL(string: imageURL)
      shopImageView.kf.setImage(with: cakeShopImageURL)
    } else {
      
    }
  }
  
  private func updateCakePrice(by sizes: [CakeShopCakeSize]) {
    sizes.forEach {
      switch $0.name {
      case "미니":
        miniSizeCakePriceLabel.text = String($0.price).moneyFormat.won
      case "1호":
        levelOneSizeCakePriceLabel.text = String($0.price).moneyFormat.won
      default:
        break
      }
    }
  }
  
  private func updateTagStackView(tags: [String]) {
    tags.forEach {
      let tagLabel = PaddingLabel()
      tagLabel.layer.borderColor = Colors.grayscale02.cgColor
      tagLabel.layer.borderWidth = 1.0
      tagLabel.text = $0
      tagLabel.textColor = Colors.grayscale04
      tagLabel.font = Fonts.spoqaHanSans(weight: .Regular, size: 11.0)
      tagLabel.backgroundColor = .clear
      tagLabel.insets = .init(top: 0, left: 4, bottom: 0, right: 4)
      tagStackView.addArrangedSubview(tagLabel)
    }
  }
}

// MARK: - Configuration

extension CakeShopCell {
  private func configure() {
    configureImageView()
  }
  
  private func configureImageView() {
    shopImageView.backgroundColor = Colors.grayscale04
  }
}
