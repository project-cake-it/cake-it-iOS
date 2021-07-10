//
//  ListBoardViewController+UITableViewDelegateFlowLayout.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

extension ListBoardViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let noticeViewController = NoticeViewController.instantiate(from: "MyPage")
    noticeViewController.notice = notices[indexPath.row]
    navigationController?.pushViewController(noticeViewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Metric.listHeight
  }
}
