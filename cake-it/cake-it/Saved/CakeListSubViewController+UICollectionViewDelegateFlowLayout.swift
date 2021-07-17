//
//  CakeListSubViewController+CollectionViewDelegate.swift
//  cake-it
//
//  Created by theodore on 2021/05/07.
//

import UIKit

extension CakeListSubViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cakeDesign = savedCakeDesigns?[indexPath.row] else { return }
    let designId = cakeDesign.id
    
    let id = String(describing: DesignDetailViewController.self)
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    if let designDetailVC = storyboard.instantiateViewController(withIdentifier: id) as? DesignDetailViewController {
      designDetailVC.designId = designId
      navigationController?.pushViewController(designDetailVC, animated: true)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width
    let cellWidth = width/2
    
    return CGSize(width: cellWidth, height: cellWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}
