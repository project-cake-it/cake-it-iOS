//
//  DesignListViewController+UICollectionViewDelegate.swift
//  cake-it
//
//  Created by Cory on 2021/03/25.
//

import UIKit

extension DesignListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfColumns = 2
    let sidePaddingsAndInterSpaces = Metric.cakeDesignsCollectionViewSidePadding * 2
      + Metric.cakeDesignCellInterItemHorizontalSpace * (CGFloat(numberOfColumns - 1))
    let side: CGFloat = (UIScreen.main.bounds.width - sidePaddingsAndInterSpaces) / CGFloat(numberOfColumns)
    let roundedSide = side.rounded(.down)
    return CGSize(width: roundedSide, height: roundedSide + 120)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Metric.cakeDesignCellInterItemVerticalSpace
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}
