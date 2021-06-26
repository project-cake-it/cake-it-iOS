//
//  HomeViewController+UICollectionViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/06/16.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    if collectionView == rankCollectionView {
      return cakeDesigns.count
    }
    
    if isThemeViewExpanded {
      return cakeDesignThemes.count
    } else {
      return themesMinCount
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == rankCollectionView {
      //TODO: 서버 연동 후 수정
      let identifider = String(describing: CakeDesignCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifider,
                                                    for: indexPath) as! CakeDesignCell
      let cakeDesign = cakeDesigns[indexPath.row]
      cell.nameLabel.text = cakeDesign.name
      return cell
    }
    
    let identifider = String(describing: ThemeCell.self)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifider,
                                                  for: indexPath) as! ThemeCell
    
    if isThemeViewExpanded == false && indexPath.row == moreButtonIndex {
      cell.updateCell(isMoreButton: true, title: "더보기")
    } else {
      cell.updateCell(title: cakeDesignThemes[indexPath.row].description)
    }
    
    return cell
  }
}
