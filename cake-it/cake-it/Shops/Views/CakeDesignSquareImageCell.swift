//
//  CakeDesignSquareImageCell.swift
//  cake-it
//
//  Created by Cory on 2021/05/10.
//

import UIKit

final class CakeDesignSquareImageCell: UICollectionViewCell {
  
  @IBOutlet weak var cakeDesignImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configure()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    cakeDesignImageView.image = nil
  }
  
  func updateCell(imageURL: String) {
    guard let cakeDesignImageURL = URL(string: imageURL) else { return }
    cakeDesignImageView.kf.setImage(with: cakeDesignImageURL)
  }
}

// MARK: - Configuration

extension CakeDesignSquareImageCell {
  private func configure() {
    configureImageView()
  }
  
  private func configureImageView() {
    cakeDesignImageView.backgroundColor = Colors.grayscale04
  }
}
