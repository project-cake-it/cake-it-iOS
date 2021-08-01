//
//  MyPageMainViewController.swift
//  cake-it
//
//  Created by Cory on 2021/02/16.
//

import UIKit
import SafariServices

final class MyPageMainViewController: BaseViewController {
  
  @IBOutlet weak var myPageMessageLabel: UILabel!
  @IBOutlet weak var myPageTableView: UITableView!
  
  let sectionTitles: [String] = ["고객센터", "정보"]
  let cellTitles = [["공지사항", "문의하기"], ["서비스 이용 약관", "개인정보 수집 및 이용", "오픈소스 라이선스", "버전 정보"]]
  let channelPublicId = "_xcpvHK"
  let headerHeight: CGFloat = 44
  
  var safariViewController: SFSafariViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureMyPageTableView()
    configureUI()
  }
  
  private func configureMyPageTableView() {
    myPageTableView.delegate = self
    myPageTableView.dataSource = self
  }
  
  private func configureUI() {
    myPageMessageLabel.text = String.init(format: Constants.MY_PAGE_MESSAGE, "사용자 닉네임")
  }
  
  @IBAction func logoutButtonDidTap(_ sender: Any) {
    //TODO: Test용 로그아웃 버튼
    LoginManager.shared.resetAccessToken();
  }
}
