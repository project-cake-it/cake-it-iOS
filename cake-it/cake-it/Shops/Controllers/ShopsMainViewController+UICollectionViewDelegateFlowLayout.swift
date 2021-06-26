//
//  ShopsMainViewController+UICollectionViewFlowLayoutDelegate.swift
//  cake-it
//
//  Created by Cory on 2021/04/07.
//

import UIKit

extension ShopsMainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    if collectionView == filterCollectionView {
      if let cell = collectionView.cellForItem(at: indexPath) as? FilterCategoryCell {
        cell.isFilterHightlighted = !cell.isFilterHightlighted
        hightlightedFilterType = cell.filterType
      }
    }
    else if collectionView == shopCollectionView {
      let identifier = String(describing: ShopDetailViewController.self)
      let storyboard = UIStoryboard(name: "Shops", bundle: nil)
      let detailVC = storyboard.instantiateViewController(withIdentifier: identifier) as! ShopDetailViewController
      detailVC.modalPresentationStyle = .fullScreen
      present(detailVC, animated: false, completion: nil)
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch collectionView {

    case filterCollectionView:
      let label = UILabel()
      label.text = shopFilterList[indexPath.row].title
      label.font = Fonts.spoqaHanSans(weight: .Medium, size: 13)
      label.sizeToFit()
      let cellWidth = label.frame.width
        + FilterCommon.Metric.categoryCellLeftInset
        + FilterCommon.Metric.categoryCellRightInset
      return CGSize(width: cellWidth, height: FilterCommon.Metric.categoryCellHeight)

    case shopCollectionView:
      let width = UIScreen.main.bounds.width
      return CGSize(width: width, height: Metric.cakeShopCellHeight)

    default:
      return CGSize(width: 0, height: 0)
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Metric.cakeShopCellInterItemVerticalSpace
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView {
    case filterCollectionView:
      return 8.0
    case shopCollectionView:
      return 0.0
    default:
      return 0.0
    }
  }
}
