//
//  DesignListViewController+UICollectionViewDataSource.swift
//  cake-it
//
//  Created by Cory on 2021/03/25.
//

import UIKit

extension DesignListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case designsCollectionView:
      return cakeDesigns.count
    case selectedFilterOptionCollectionView:
      return selectedFilterOptions.count
    case filterCategoryCollectionView:
      return cakeFilterList.count
    default:
      return 0
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    case designsCollectionView:
      let identifier = String(describing: CakeDesignCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! CakeDesignCell
      let cakeDesign = cakeDesigns[indexPath.row]
      cell.update(with: cakeDesign)
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
    case filterCategoryCollectionView:
      let identifier = String(describing: FilterCategoryCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! FilterCategoryCell
      cell.delegate = self
      cell.update(type: cakeFilterList[indexPath.row],
                  highlightedFilterType: highlightedFilterType,
                  selectedFilter: selectedFilter)
      return cell
    default:
      return UICollectionViewCell()
    }
  }
}
