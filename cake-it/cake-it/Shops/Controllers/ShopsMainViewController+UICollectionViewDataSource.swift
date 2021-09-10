//
//  ShopsMainViewController+UICollectionViewDataSource.swift
//  cake-it
//
//  Created by Cory on 2021/04/07.
//

import UIKit

extension ShopsMainViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case filterCollectionView:
      return shopFilterList.count
    case shopCollectionView:
      return cakeShops.count
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == filterCollectionView {
      let identifier = String(describing: FilterCategoryCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! FilterCategoryCell
      cell.delegate = self
      cell.update(type: shopFilterList[indexPath.row],
                  highlightedFilterType: highlightedFilterType,
                  selectedFilter: selectedFilter)
      return cell
    }
    else if collectionView == shopCollectionView {
      let identifier = String(describing: CakeShopCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! CakeShopCell
      let cakeShop = cakeShops[indexPath.row]
      cell.update(with: cakeShop)
      return cell
    }
    else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if collectionView == filterCollectionView {
      if let cell = collectionView.cellForItem(at: indexPath) as? FilterCategoryCell {
        cell.isFilterHighlighted = false
        highlightedFilterType = .reset
      }
    }
  }
}
