//
//  HomeViewController+UICollectionViewDelegate.swift
//  cake-it
//
//  Created by theodore on 2021/06/16.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if (isThemeViewExpand == false && indexPath.row == 3) {
      isThemeViewExpand = true
      return
    }
    
    let viewController = DesignListViewController.instantiate(from: "Home")
    viewController.modalPresentationStyle = .fullScreen
    viewController.cakeTheme = cakeDesignThemes[indexPath.row]
    present(viewController, animated: true)
  }
}
