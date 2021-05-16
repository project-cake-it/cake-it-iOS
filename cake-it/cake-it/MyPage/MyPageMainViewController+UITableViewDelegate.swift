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
      let navigationController = UINavigationController(rootViewController: noticeListViewController)
      navigationController.modalPresentationStyle = .overFullScreen
      present(navigationController, animated: false, completion: nil)
      return
    }
    
    let infomationViewController = InfomationViewController.instantiate(from: "MyPage")
    infomationViewController.modalPresentationStyle = .overFullScreen
    present(infomationViewController, animated: false, completion: nil)
  }
}
