//
//  CakeListSubViewController+CollectionViewDelegate.swift
//  cake-it
//
//  Created by theodore on 2021/05/07.
//

import UIKit

extension CakeListSubViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width
    let cellWidth = width/2
    
    return CGSize(width: cellWidth, height: cellWidth)
  }
}
