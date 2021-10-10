//
//  FilterDetailViewController+UITableViewDelegate.swift
//  cake-it
//
//  Created by seungbong on 2021/07/18.
//

import UIKit

extension FilterDetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    updateSelectedList(selectedIndex: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if FilterManager.shared.isMultiSelectionEnabled(type: filterType) == true {
      let id = String(describing: FilterTableHeaderCell.self)
      if let headerCell = tableView.dequeueReusableCell(withIdentifier: id) as? FilterTableHeaderCell {
        headerCell.delegate = self
        if selectedList.isEmpty || isAllFilterSelected() {
            headerCell.isCellSelected = true
        } else {
            headerCell.isCellSelected = false
        }
        return headerCell
      }
    }
    return nil
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    footerView.backgroundColor = .clear
    return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if filterType == .size {
      return Metric.largeTableCellHight
    } else {
      return Metric.defaultTableCellHight
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if FilterManager.shared.isMultiSelectionEnabled(type: filterType) == true {
      return Metric.headerCellHeight
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return Metric.footerCellHeight
  }
}
