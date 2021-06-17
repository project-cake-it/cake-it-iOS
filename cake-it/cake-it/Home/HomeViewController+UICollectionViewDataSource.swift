//
//  HomeViewController+UICollectionViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/06/16.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if (isThemeViewExpand) {
      return cakeDesignThemes.count
    } else {
      return themeListMinSize
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifider = String(describing: ThemeCell.self)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifider, for: indexPath) as! ThemeCell
    
    if (isThemeViewExpand == false && indexPath.row == 3) {
      cell.updateCell(isThemeCell: false, titleString: "더보기")
    } else {
      cell.updateCell(isThemeCell: true, titleString: cakeDesignThemes[indexPath.row].description)
    }
    
    return cell
  }
}
