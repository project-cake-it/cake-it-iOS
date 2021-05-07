//
//  ShopListSubViewController+UICollectionViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/05/07.
//

import UIKit

extension ShopListSubViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cakeShops.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: CakeShopCell.self)
    let cell = cakeShopCollectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                          for: indexPath) as! CakeShopCell
    let cakeShop = cakeShops[indexPath.row]
    cell.update(with: cakeShop)
    return cell
  }
  
  
}
