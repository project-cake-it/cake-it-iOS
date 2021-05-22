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
    case filterTitleCollectionView:
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
      
    case filterTitleCollectionView:
      let identifier = String(describing: FilterTitleCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! FilterTitleCell
      cell.update(title: cakeFilterList[indexPath.row].korTitle)
      return cell
      
    default:
      let identifier = "EmptyCell"
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                    for: indexPath) as! FilterTitleCell
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionView {
    case designsCollectionView:
      let id = String(describing: DesignDetailViewController.self)
      if let desingDetailVC = storyboard?.instantiateViewController(identifier: id) {
        desingDetailVC.modalPresentationStyle = .fullScreen
        present(desingDetailVC, animated: true, completion: nil)
      }
    case filterTitleCollectionView:
      break
    default:
      break
    }
  }
  
  
}
