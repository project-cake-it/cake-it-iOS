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
    return cakeDesigns.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: CakeDesignCell.self)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                  for: indexPath) as! CakeDesignCell
    let cakeDesign = cakeDesigns[indexPath.row]
    cell.update(with: cakeDesign)
    return cell
  }
}
