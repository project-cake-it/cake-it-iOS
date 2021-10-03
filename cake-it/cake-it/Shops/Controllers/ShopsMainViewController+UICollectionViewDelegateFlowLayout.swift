//
//  ShopsMainViewController+UICollectionViewFlowLayoutDelegate.swift
//  cake-it
//
//  Created by Cory on 2021/04/07.
//

import UIKit

extension ShopsMainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionView {
    case filterCollectionView:
      guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCategoryCell else { return }
      cell.isFilterHighlighted = !cell.isFilterHighlighted // 재사용 warning..?
      highlightedFilterType = cell.filterType
    case shopCollectionView:
      let identifier = String(describing: ShopDetailViewController.self)
      let storyboard = UIStoryboard(name: "Shops", bundle: nil)
      let detailVC = storyboard.instantiateViewController(withIdentifier: identifier) as! ShopDetailViewController
      let cakeShop = cakeShops[indexPath.row]
      detailVC.fetchDetail(id: cakeShop.id)
      navigationController?.pushViewController(detailVC, animated: true)
    default:
      break
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    switch collectionView {
    case filterCollectionView:
      let filterType = shopFilterList[indexPath.row]
      let isSelected = selectedFilter[filterType.key]?.count ?? 0 > 0
      let filterValues = selectedFilter[filterType.key] ?? []

      let label = UILabel()
      label.text = FilterManager.shared.filterTitle(isSelected: isSelected,
                                                    filterType: filterType,
                                                    filterValues: filterValues)
      label.font = Fonts.spoqaHanSans(weight: .Medium, size: 13)
      label.sizeToFit()
      let cellWidth = label.frame.width
        + FilterCommon.Metric.categoryCellLeftInset
        + FilterCommon.Metric.categoryCellRightInset
      return CGSize(width: cellWidth, height: FilterCommon.Metric.categoryCellHeight)
    case selectedFilterOptionCollectionView:
      let label = UILabel()
      let options = selectedFilterOptions
      let option = options[indexPath.row]
      let title = option.title()
      label.font = Fonts.spoqaHanSans(weight: .Medium, size: 13)
      label.text = title
      label.sizeToFit()
      let cellWidth = label.frame.width
        + SelectedFilterOptionCell.Metric.leftInset
        + SelectedFilterOptionCell.Metric.rightInset
      return CGSize(width: cellWidth, height: SelectedFilterOptionCell.Metric.height)
    case shopCollectionView:
      let width = UIScreen.main.bounds.width
      return CGSize(width: width, height: Metric.cakeShopCellHeight)
    default:
      return CGSize(width: 0, height: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    switch collectionView {
    case filterCollectionView:
      return 8.0
    case selectedFilterOptionCollectionView:
      return SelectedFilterOptionCell.Metric.interItemSpace
    case shopCollectionView:
      return Metric.cakeShopCellInterItemVerticalSpace
    default:
      return 0.0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    switch collectionView {
    case filterCollectionView:
      return 8.0
    case selectedFilterOptionCollectionView:
      return 0
    case shopCollectionView:
      return 0
    default:
      return 0
    }
  }
}
