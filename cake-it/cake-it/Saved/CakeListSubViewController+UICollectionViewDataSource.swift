//
//  CakeListSubViewController+CollectionViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/05/05.
//

import UIKit

extension CakeListSubViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return cakeImages.count;
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cakeImageCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CakeImageCell", for: indexPath) as! CakeImageCell
    
    let cakeImageURL = URL(string: cakeImages[indexPath.row])!
    DispatchQueue.global().async {
      let data = try? Data(contentsOf: cakeImageURL)
      DispatchQueue.main.async {
        cakeImageCell.cakeImageView.image = UIImage(data: data!)
      }
    }
    
    return cakeImageCell
  }
}
