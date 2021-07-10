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
      return CGSize(width: roundedSide, height: roundedSide + Metric.cakeDesignCellInfoAreaHeight)
    case themeCollectionView:
      let numberOfColumns: CGFloat = 2
      let themeCellWidth = (collectionView.frame.width
                              - Metric.themeCollectionViewInterItemHorizontalSpace) / numberOfColumns
      return CGSize(width: themeCellWidth.rounded(.down), height: Metric.themeCellHeight)
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
      return Metric.themeCollectionViewInterItemHorizontalSpace
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionView {
    case rankCollectionView:
      let identifier = String(describing: DesignDetailViewController.self)
      let storyboard = UIStoryboard(name: "Home", bundle: nil)
      if let designDetailVC = storyboard.instantiateViewController(withIdentifier: identifier)
          as? DesignDetailViewController {
        designDetailVC.designId = cakeDesigns[indexPath.row].id
        navigationController?.pushViewController(designDetailVC, animated: true)
      }
      break
    case themeCollectionView:
      if isThemeViewExpanded == false && indexPath.row == moreButtonIndex {
        isThemeViewExpanded = true
        return
      }
      let viewController = DesignListViewController.instantiate(from: "Home")
      navigationController?.pushViewController(viewController, animated: true)
      viewController.selectedThemeType = cakeDesignThemes[indexPath.row]
      break
    default:
      break
    }
  }
}
