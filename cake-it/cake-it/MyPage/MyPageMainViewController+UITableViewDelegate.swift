//
//  MyPageMainViewController+UITableViewDelegate.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit
import WebKit
import KakaoSDKTalk
import SafariServices

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
        guard let channelURL = TalkApi.shared.makeUrlForChannelChat(channelPublicId: channelPublicId) else {
          return
        }
        
        safariViewController = SFSafariViewController(url: channelURL)
        self.present(safariViewController!, animated: true, completion: nil)
        return
      default:
        return
      }
    }
    
    let infomationViewController = InfomationViewController.instantiate(from: "MyPage")

    if indexPath.section == 1 {
      switch indexPath.row {
      case 0:
        guard let localFile = Bundle.main.path(forResource: "terms", ofType: "html") else { return }
        let url = URL(fileURLWithPath: localFile)
        infomationViewController.configureViewController(url: url,
                                                         title: self.cellTitles[indexPath.section][indexPath.row])
        navigationController?.pushViewController(infomationViewController, animated: true)
        return
      case 1:
        guard let localFile = Bundle.main.path(forResource: "personalinfomation", ofType: "html") else { return }
        let url = URL(fileURLWithPath: localFile)
        infomationViewController.configureViewController(url: url,
                                                         title: self.cellTitles[indexPath.section][indexPath.row])
        navigationController?.pushViewController(infomationViewController, animated: true)
        return
      case 2:
        // 로그인 / 로그아웃
        updateLogin()
        return
      case 3:
        // 버전정보
        // 터치 반응없음
        return
      default:
        return
      }
    }
  }
}
