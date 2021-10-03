//
//  MyPageMainViewController+UITableViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

extension MyPageMainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return headerHeight
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionTitles[section]
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    view.tintColor = .white
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return cellTitles.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellTitles[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = String(describing: MyPageCell.self)
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyPageCell
    cell.updateCell(title: cellTitles[indexPath.section][indexPath.row])
    
    return cell
  }
}
