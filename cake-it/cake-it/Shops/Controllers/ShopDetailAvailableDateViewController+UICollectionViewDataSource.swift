//
//  CakeOrderAvailableDateViewController+UICollectionViewDataSource.swift
//  cake-it
//
//  Created by Cory on 2021/08/08.
//

import UIKit

extension CakeOrderAvailableDateViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int
  ) -> Int {
    guard totalOrderDates.count > 0 else { return 0 }
    let orderDatesByMonth = totalOrderDates[currentMonthIndex]
    return orderDatesByMonth.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let id = String(describing: CakeOrderAvailableDateCell.self)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! CakeOrderAvailableDateCell
    let date = totalOrderDates[currentMonthIndex][indexPath.row]
    cell.update(with: date)
    return cell
  }
}
