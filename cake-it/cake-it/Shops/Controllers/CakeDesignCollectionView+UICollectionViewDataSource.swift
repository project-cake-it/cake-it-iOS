//
//  CakeDesignCollectionView+UICollectionViewDataSource.swift
//  cake-it
//
//  Created by Cory on 2021/05/10.
//

import UIKit

extension ShopDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return cakeDesigns.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: CakeDesignSquareImageCell.self)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CakeDesignSquareImageCell
    if let imageInfo = cakeDesigns[indexPath.row].designImages.first {
       let url = imageInfo.designImageUrl
      cell.updateCell(imageURL: url)
    }
    
    return cell
  }
}
