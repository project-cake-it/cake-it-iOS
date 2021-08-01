//
//  ShopListSubViewController+UICollecionViewDelegateFlowLayout.swift
//  cake-it
//
//  Created by theodore on 2021/05/07.
//

import UIKit

extension ShopListSubViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let id = String(describing: ShopDetailViewController.self)
    let storyboard = UIStoryboard(name: "Shops", bundle: nil)
    if let shopDetailVC = storyboard.instantiateViewController(withIdentifier: id) as? ShopDetailViewController {
      shopDetailVC.fetchDetail(id: savedCakeShops[indexPath.row].id)
      navigationController?.pushViewController(shopDetailVC, animated: true)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    return CGSize(width: width, height: Metric.cakeShopCellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Metric.cakeShopCellInterItemVerticalSpace
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}
