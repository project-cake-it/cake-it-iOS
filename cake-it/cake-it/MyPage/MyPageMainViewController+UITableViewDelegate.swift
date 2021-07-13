//
//  MyPageMainViewController+UITableViewDelegate.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit
import WebKit

extension MyPageMainViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if indexPath.section == 0 {
      switch indexPath.row {
      case 0:
        let noticeListViewController = ListBoardViewController.instantiate(from: "MyPage")
        navigationController?.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(noticeListViewController, animated: true)
        return
      case 1:
        //TODO: 카카오톡 플러스 연결
        return
      default:
        return
      }
    }
    
    let infomationViewController = InfomationViewController.instantiate(from: "MyPage")

    if indexPath.section == 1 {
      switch indexPath.row {
      case 0:
        let localFile = Bundle.main.path(forResource: "terms", ofType: "html")
        let url = URL(fileURLWithPath: localFile!)
        infomationViewController.url = url
        navigationController?.pushViewController(infomationViewController, animated: true)
        return
      case 1:
        let localFile = Bundle.main.path(forResource: "personalinfomation", ofType: "html")
        let url = URL(fileURLWithPath: localFile!)
        infomationViewController.url = url
        navigationController?.pushViewController(infomationViewController, animated: true)
        return
      case 2:
        return
      case 3:
        return
      default:
        return
      }
    }
  }
}
