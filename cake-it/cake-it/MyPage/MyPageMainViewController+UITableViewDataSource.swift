//
//  MyPageMainViewController+UITableViewDataSource.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

extension MyPageMainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return Constants.MY_PAGE_SECTION_1_TITLE
    case 1:
      return Constants.MY_PAGE_SECTION_2_TITLE
    default:
      return ""
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    view.tintColor = .white
  }
  
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
