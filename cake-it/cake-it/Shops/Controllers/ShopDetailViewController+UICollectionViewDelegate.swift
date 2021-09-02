//
//  ShopDetailViewController+UICollectionViewDelegate.swift
//  cake-it
//
//  Created by Cory on 2021/05/10.
//

import UIKit

extension ShopDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfColumns: CGFloat = 2
    let sidePaddingsAndInterSpaces = Metric.cakeDesignsCollectionViewSidePadding * 2
      + Metric.cakeDesignCellInterItemHorizontalSpace * (numberOfColumns - 1)
    let side: CGFloat = (UIScreen.main.bounds.width - sidePaddingsAndInterSpaces) / numberOfColumns
    let roundedSide = side.rounded(.down)
    return CGSize(width: roundedSide, height: roundedSide)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Metric.cakeDesignCellInterItemVerticalSpace
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let identifier = String(describing: DesignDetailViewController.self)
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    if let designDetailVC = storyboard.instantiateViewController(withIdentifier: identifier)
        as? DesignDetailViewController {
      designDetailVC.designID = cakeDesigns[indexPath.row].id
      navigationController?.pushViewController(designDetailVC, animated: true)
    }
  }
}
