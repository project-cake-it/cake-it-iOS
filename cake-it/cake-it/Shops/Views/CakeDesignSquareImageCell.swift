//
//  CakeDesignSquareImageCell.swift
//  cake-it
//
//  Created by Cory on 2021/05/10.
//

import UIKit

final class CakeDesignSquareImageCell: UICollectionViewCell {
  
  @IBOutlet weak var cakeDesignImageView: UIImageView!
  
  func updateCell(imageURL: String) {
    let cakeDesignImageURL = URL(string: imageURL)
    DispatchQueue.global().async {
      let data = try? Data(contentsOf: cakeDesignImageURL!)
      DispatchQueue.main.async {
        self.cakeDesignImageView.image = UIImage(data: data!)
      }
    }
  }
}
