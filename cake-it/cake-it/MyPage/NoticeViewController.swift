//
//  NoticeViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

final class NoticeViewController: BaseViewController {
  
  @IBOutlet weak var noticeViewTitleLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var textLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}
