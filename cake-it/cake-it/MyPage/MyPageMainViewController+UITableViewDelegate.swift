//
//  MyPageMainViewController+UITableViewDelegate.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

extension MyPageMainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if indexPath.row == 1 {
      let noticeListViewController = ListBoardViewController.instantiate(from: "MyPage")
      noticeListViewController.modalPresentationStyle = .overFullScreen
      self.present(noticeListViewController, animated: false, completion: nil)
      return
    }
    
    let infomationViewController = InfomationViewController.instantiate(from: "MyPage")
    infomationViewController.modalPresentationStyle = .overFullScreen
    self.present(infomationViewController, animated: false, completion: nil)
  }
}
