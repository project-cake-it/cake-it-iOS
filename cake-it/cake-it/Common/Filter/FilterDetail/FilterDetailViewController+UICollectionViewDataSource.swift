//
//  FilterDetailViewController+UICollectionViewDataSource.swift
//  cake-it
//
//  Created by Cory on 2021/09/13.
//

import UIKit

extension FilterDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int
  ) -> Int {
    if collectionView == pickUpCalendarCollectionView {
      guard totalPickUpAvailableDates.count > 0 else { return 0 }
      let orderDatesByMonth = totalPickUpAvailableDates[currentMonthIndex]
      return orderDatesByMonth.count
    }
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    if collectionView == pickUpCalendarCollectionView {
      let id = String(describing: CakeOrderAvailableDateCell.self)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! CakeOrderAvailableDateCell
      let date = totalPickUpAvailableDates[currentMonthIndex][indexPath.row]
      cell.update(with: date)
      if date == selectedPickUpDate {
        cell.selected()
      }
      return cell
    }
    return UICollectionViewCell()
  }
}
