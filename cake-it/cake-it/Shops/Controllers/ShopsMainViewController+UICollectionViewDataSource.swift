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
    return cakeShops.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: CakeShopCell.self)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                  for: indexPath) as! CakeShopCell
    let cakeShop = cakeShops[indexPath.row]
    cell.update(with: cakeShop)
    return cell
  }
}
