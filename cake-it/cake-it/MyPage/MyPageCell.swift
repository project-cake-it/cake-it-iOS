//
//  MyPageCell.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

final class MyPageCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet var versionLabel: UILabel!
  @IBOutlet var rightIcon: UIImageView!
  
  let cellTitles = [["공지사항", "문의하기"], ["서비스 이용 약관", "개인정보 수집 및 이용", "오픈소스 라이선스", "버전 정보"]]
  
  func updateCell(section: Int, index: Int) {
    titleLabel.text = cellTitles[section][index]
    
    if section == 1, index == 3 {
      versionLabel.isHidden = false
      rightIcon.isHidden = true
      versionLabel.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    } else {
      versionLabel.isHidden = true
      rightIcon.isHidden = false
    }
  }
}
