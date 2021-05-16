//
//  MyPageMainViewController+UITableViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

extension MyPageMainViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return firstSections.count
    case 1:
      return secondSections.count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = String(describing: MyPageCell.self)
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyPageCell
    
    switch indexPath.section {
    case 0:
      cell.titleLabel.text = firstSections[indexPath.row]
    case 1:
      cell.titleLabel.text = secondSections[indexPath.row]
    default:
      break
    }
    
    return cell
  }
}
