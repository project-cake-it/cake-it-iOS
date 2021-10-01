//
//  FilterDetailViewController+UICollectionViewDelegate.swift
//  cake-it
//
//  Created by Cory on 2021/09/13.
//

import UIKit

extension FilterDetailViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == pickUpCalendarCollectionView {
      let dates = totalPickUpAvailableDates[currentMonthIndex]
      let date = dates[indexPath.row]
      self.selectedPickUpDate = date
      let cell = collectionView.cellForItem(at: indexPath) as! CakeOrderAvailableDateCell
      cell.selected()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = collectionView.bounds.width / 7.0
    return CGSize(width: width, height: 44.0)
  }
}
