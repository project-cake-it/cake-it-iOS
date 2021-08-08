//
//  ShopDetailAvailableDateViewController+UICollectionViewDelegate.swift
//  cake-it
//
//  Created by Cory on 2021/08/08.
//

import UIKit

extension ShopDetailAvailableDateViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = collectionView.bounds.width / 7.0
    return CGSize(width: width, height: 44.0)
  }
}
