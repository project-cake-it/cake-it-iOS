//
//  MyPageMainViewController.swift
//  cake-it
//
//  Created by Cory on 2021/02/16.
//

import UIKit
import SafariServices

final class MyPageMainViewController: BaseViewController, LoginViewcontrollerDelegate {
  
  @IBOutlet var myPageMessageViewHeight: NSLayoutConstraint!
  @IBOutlet weak var myPageMessageLabel: UILabel!
  @IBOutlet weak var myPageTableView: UITableView!
  
  let sectionTitles: [String] = ["고객센터", "정보"]
  var cellTitles = [["공지사항", "문의하기"], ["서비스 이용 약관", "개인정보 수집 및 이용", "로그인", "버전 정보"]]
  let channelPublicId = "_xcpvHK"
  let headerHeight: CGFloat = 44
  let messageViewHeight = 64
  
  var safariViewController: SFSafariViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureMyPageTableView()
    configureUI()
    updateUserInfo()
  }
  
  // MARK: - private method
  
  private func configureMyPageTableView() {
    myPageTableView.delegate = self
    myPageTableView.dataSource = self
  }
  
  private func configureUI() {
    myPageMessageLabel.text = String.init(format: Constants.MY_PAGE_MESSAGE, "사용자 닉네임")
    updateCellTitles()
  }
  
  private func updateCellTitles() {
    if (LoginManager.shared.isLogin()) {
      cellTitles[1][2] = "로그아웃"
    } else {
      cellTitles[1][2] = "로그인"
    }
    myPageTableView.reloadData()
  }
  
  private func updateUserInfo() {
    if LoginManager.shared.isLogin() {
      myPageMessageViewHeight.constant = 0
    } else {
      //TODO: 닉네임 기능 서버 업데이트 후 수정
      myPageMessageViewHeight.constant = 0
    }
  }
  
  func updateLogin() {
    if LoginManager.shared.isLogin() {
      LoginManager.shared.resetAccessToken()
      view.showToast(message: "로그아웃 되었습니다")
      updateCellTitles()
    } else {
      let storyboard = UIStoryboard(name: "Home", bundle: nil)
      let loginVC = storyboard.instantiateViewController(withIdentifier: LoginViewController.id) as! LoginViewController
      loginVC.modalPresentationStyle = .overFullScreen
      loginVC.delegate = self
      present(loginVC, animated: false, completion: nil)
    }
  }
  
  // MARK: - delegate
  func loginDidFinnish(_ viewController: LoginViewController, _ success: Bool) {
    if success {
      viewController.dismiss(animated: false) {
        self.updateCellTitles()
        self.view.showToast(message: "로그인 되었습니다")
      }
    }
  }
}
