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
    case filterHeaderCollectionView:
      return cakeFilterList.count
    default:
      return 0
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == designsCollectionView {
      let identifier = String(describing: CakeDesignCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! CakeDesignCell
      let cakeDesign = cakeDesigns[indexPath.row]
      cell.update(with: cakeDesign)
      return cell
    }
    else if collectionView == filterHeaderCollectionView {
      let identifier = String(describing: FilterHeaderCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! FilterHeaderCell
      let filterType = cakeFilterList[indexPath.row]
      var isSelected = false
      if selectedFilterDic.keys.contains(filterType.title)
          && selectedFilterDic[filterType.title]?.count ?? 0 > 0 {
        isSelected = true
      }
      var isHighlighted = false
      if hightlightedFilterType == filterType && hightlightedFilterType != .reset {
        isHighlighted = true
      }
      cell.delegate = self
      cell.update(type: filterType,isHighlighted: isHighlighted, isSelected: isSelected)
      return cell
    }
    else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == designsCollectionView {
      let id = String(describing: DesignDetailViewController.self)
      if let desingDetailVC = storyboard?.instantiateViewController(identifier: id) {
        desingDetailVC.modalPresentationStyle = .fullScreen
        present(desingDetailVC, animated: true, completion: nil)
      }
    }
    else if collectionView == filterHeaderCollectionView {
      if let cell = collectionView.cellForItem(at: indexPath) as? FilterHeaderCell {
        cell.isFilterHightlighted = !cell.isFilterHightlighted
        hightlightedFilterType = cell.filterType
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if collectionView == filterHeaderCollectionView {
      if let cell = collectionView.cellForItem(at: indexPath) as? FilterHeaderCell {
        cell.isFilterHightlighted = false
        hightlightedFilterType = .reset
      }
    }
  }
}
