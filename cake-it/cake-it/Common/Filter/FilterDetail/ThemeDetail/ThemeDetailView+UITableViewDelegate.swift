//
//  ThemeDetailView+UITableViewDelegate.swift
//  cake-it
//
//  Created by seungbong on 2021/06/20.
//

import UIKit

extension ThemeDetailView: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row >= FilterCommon.FilterTheme.allCases.count {
      return
    }
    selectedTheme = FilterCommon.FilterTheme.allCases[indexPath.row]
    themeTableView.reloadData()
    delegate?.themeDetailCellDidTap(type: selectedTheme)
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    footerView.backgroundColor = .clear
    return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Metric.defaultTableCellHight
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return Metric.footerCellHeight
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    tableViewHeight += cell.frame.height
    themeTableViewHeightConstraint?.constant = tableViewHeight
  }
  
  func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    tableViewHeight += view.frame.height
    themeTableViewHeightConstraint?.constant = tableViewHeight
  }
}
