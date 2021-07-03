//
//  ShopListSubViewController+UICollectionViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/05/07.
//

import UIKit

extension ShopListSubViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return savedCakeShops.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: CakeShopCell.self)
    let cell = cakeShopCollectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                          for: indexPath) as! CakeShopCell
    let savedShop = savedCakeShops[indexPath.row]
    cell.update(with: savedShop)
    return cell
  }
}
