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
    case selectedFilterOptionCollectionView:
      return selectedFilterOptions.count
    case shopCollectionView:
      return cakeShops.count
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    case filterCollectionView:
      let identifier = String(describing: FilterCategoryCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! FilterCategoryCell
      cell.delegate = self
      cell.update(type: shopFilterList[indexPath.row],
                  highlightedFilterType: highlightedFilterType,
                  selectedFilter: selectedFilter)
      return cell
    case selectedFilterOptionCollectionView:
      let identifier = String(describing: SelectedFilterOptionCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! SelectedFilterOptionCell
      cell.delegate = self
      let options = selectedFilterOptions
      let option = options[indexPath.row]
      cell.update(with: option)
      return cell
    case shopCollectionView:
      let identifier = String(describing: CakeShopCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! CakeShopCell
      let cakeShop = cakeShops[indexPath.row]
      cell.update(with: cakeShop)
      return cell
    default:
      return UICollectionViewCell()
    }
  }
}
