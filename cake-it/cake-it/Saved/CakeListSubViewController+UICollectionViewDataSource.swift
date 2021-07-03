//
//  CakeListSubViewController+CollectionViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/05/05.
//

import UIKit
import Kingfisher

extension CakeListSubViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return savedCakeDesigns?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: CakeImageCell.self)
    let cakeImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                           for: indexPath) as! CakeImageCell
    guard let savedCakeDesigns = savedCakeDesigns else {
      return cakeImageCell
    }

    if let imageInfo = savedCakeDesigns[indexPath.row].designImages.first,
       let imageUrl = URL(string: imageInfo.designImageUrl) {
      cakeImageCell.cakeImageView.kf.setImage(with: imageUrl)
    }
    
    return cakeImageCell
  }
}
