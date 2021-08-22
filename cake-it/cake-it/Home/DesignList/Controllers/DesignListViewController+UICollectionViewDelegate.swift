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
    if collectionView.numberOfItems(inSection: section) == 1 {
      let numberOfColumns = 2
      let sidePaddingsAndInterSpaces = Metric.cakeDesignsCollectionViewSidePadding
      + Metric.cakeDesignCellInterItemHorizontalSpace
      let side: CGFloat = (UIScreen.main.bounds.width - sidePaddingsAndInterSpaces) / CGFloat(numberOfColumns)
      let roundedSide = side.rounded(.down)
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: roundedSide)
    }
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch collectionView {
    
    case designsCollectionView:
      let numberOfColumns = 2
      let sidePaddingsAndInterSpaces = Metric.cakeDesignsCollectionViewSidePadding * 2
        + Metric.cakeDesignCellInterItemHorizontalSpace * (CGFloat(numberOfColumns - 1))
      let side: CGFloat = (UIScreen.main.bounds.width - sidePaddingsAndInterSpaces) / CGFloat(numberOfColumns)
      let roundedSide = side.rounded(.down)
      return CGSize(width: roundedSide, height: roundedSide + 120)
      
    case filterCategoryCollectionView:
      let label = UILabel()
      label.text = cakeFilterList[indexPath.row].title
      label.font = Fonts.spoqaHanSans(weight: .Medium, size: 13)
      label.sizeToFit()
      let cellWidth = label.frame.width
        + FilterCommon.Metric.categoryCellLeftInset
        + FilterCommon.Metric.categoryCellRightInset
      return CGSize(width: cellWidth, height: FilterCommon.Metric.categoryCellHeight)
      
    default:
      return CGSize(width: 0, height: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return Metric.cakeDesignCellInterItemVerticalSpace
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView {
    case designsCollectionView:
      return 0.0
    case filterCategoryCollectionView:
      return 8.0
    default:
      return 0.0
    }
  }

}
