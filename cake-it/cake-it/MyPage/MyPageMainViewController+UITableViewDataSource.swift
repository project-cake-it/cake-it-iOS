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
      return firstSection.count
    case 1:
      return secondSection.count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyPageCell
    
    switch indexPath.section {
    case 0:
      cell.cellTitle.text = firstSection[indexPath.row]
    case 1:
      cell.cellTitle.text = secondSection[indexPath.row]
    default:
      break
    }
    
    return cell
  }
}
