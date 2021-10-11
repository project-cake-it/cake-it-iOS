//
//  DesignListViewController+UICollectionViewDelegate.swift
//  cake-it
//
//  Created by Cory on 2021/03/25.
//

import UIKit

extension DesignListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionView {
    case designsCollectionView:
      let id = String(describing: DesignDetailViewController.self)
      let storyboard = UIStoryboard(name: "Home", bundle: nil)
      guard let designDetailVC = storyboard.instantiateViewController(withIdentifier: id) as? DesignDetailViewController else { return }
      designDetailVC.designID = cakeDesigns[indexPath.row].id
      navigationController?.pushViewController(designDetailVC, animated: true)
    case filterCategoryCollectionView:
      guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCategoryCell else { return }
      cell.isFilterHighlighted = !cell.isFilterHighlighted
      highlightedFilterType = cell.filterType
    default:
      break
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if collectionView == filterCategoryCollectionView {
      if let cell = collectionView.cellForItem(at: indexPath) as? FilterCategoryCell {
        cell.isFilterHighlighted = false
        highlightedFilterType = .reset
      }
    }
  }
  
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
      let filterType = cakeFilterList[indexPath.row]
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
    default:
      return CGSize(width: 0, height: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView {
    case filterCategoryCollectionView:
      return Metric.filterCollectionViewInterItemSpacing
    case selectedFilterOptionCollectionView:
      return SelectedFilterOptionCell.Metric.interItemSpace
    case designsCollectionView:
      return Metric.cakeDesignCellInterItemVerticalSpace
    default:
      return 0.0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView {
    case designsCollectionView:
      return 0.0
    case filterCategoryCollectionView:
      return Metric.filterCollectionViewInterItemSpacing
    case selectedFilterOptionCollectionView:
      return SelectedFilterOptionCell.Metric.interItemSpace
    default:
      return 0.0
    }
  }
}
