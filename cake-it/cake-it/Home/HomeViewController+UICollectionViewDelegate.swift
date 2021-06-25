//
//  HomeViewController+UICollectionViewDelegate.swift
//  cake-it
//
//  Created by theodore on 2021/06/16.
//

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch collectionView {
    case rankCollectionView:
      let numberOfColumns = 2
      let sidePaddingsAndInterSpaces = Metric.rankCollectionViewSidePadding * 2
        + Metric.cakeDesignCellInterItemHorizontalSpace * (CGFloat(numberOfColumns - 1))
      let side: CGFloat = (UIScreen.main.bounds.width - sidePaddingsAndInterSpaces) / CGFloat(numberOfColumns)
      let roundedSide = side.rounded(.down)
      self.rankCollectionViewCellHeight = roundedSide + 120
      return CGSize(width: roundedSide, height: roundedSide + 120)
    case themeCollectionView:
      return CGSize(width: Metric.themeCellWidth, height: Metric.themeCellHeight)
    default:
      return CGSize(width: 0, height: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView {
    case rankCollectionView:
      return Metric.cakeDesignCellInterItemVerticalSpace
    case themeCollectionView:
      return Metric.themeCollectionViewInterItemVerticalSpace
    default:
      return 0;
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView {
    case themeCollectionView:
      return Metric.themeCollectionViewInterItemVerticalSpace
    default:
      return 0
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if (collectionView == rankCollectionView) {
      return
    }
    
    if (isThemeViewExpand == false && indexPath.row == 3) {
      // 더보기 cell 터치
      isThemeViewExpand = true
      return
    }
    
    let viewController = DesignListViewController.instantiate(from: "Home")
    viewController.modalPresentationStyle = .overFullScreen
    viewController.cakeTheme = cakeDesignThemes[indexPath.row]
    present(viewController, animated: true)
  }
}
