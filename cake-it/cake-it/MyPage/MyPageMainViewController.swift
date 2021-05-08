//
//  MyPageMainViewController.swift
//  cake-it
//
//  Created by Cory on 2021/02/16.
//

import UIKit

final class MyPageMainViewController: UIViewController {
  
  @IBOutlet weak var myPageMessage: UILabel!
  @IBOutlet weak var myPageTableView: UITableView!
  
  let firstSection: [String] = ["고객센터", "공지사항", "문의하기"]
  let secondSection: [String] = ["정보", "서비스 이용 약관", "개인정보 수집 및 이용", "오픈소스 라이선스", "버전 정보"]
  
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
    myPageMessage.text = String.init(format: Constants.MY_PAGE_MESSAGE, "사용자 닉네임")
  }
}
