//
//  CakeListSubViewController+CollectionViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/05/05.
//

import UIKit

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
      DispatchQueue.global().async {
        if let imageData = try? Data(contentsOf: imageUrl),
           let designImage = UIImage(data: imageData) {
          DispatchQueue.main.async {
            cakeImageCell.cakeImageView.image = designImage
          }
        }
      }
    }
    
    return cakeImageCell
  }
}
