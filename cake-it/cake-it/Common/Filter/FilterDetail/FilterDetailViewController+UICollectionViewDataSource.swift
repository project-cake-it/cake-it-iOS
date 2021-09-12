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
    guard totalPickUpAvailableDates.count > 0 else { return 0 }
    let orderDatesByMonth = totalPickUpAvailableDates[currentMonthIndex]
    return orderDatesByMonth.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let id = String(describing: CakeOrderAvailableDateCell.self)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! CakeOrderAvailableDateCell
    let date = totalPickUpAvailableDates[currentMonthIndex][indexPath.row]
    cell.update(with: date)
    return cell
  }
}
