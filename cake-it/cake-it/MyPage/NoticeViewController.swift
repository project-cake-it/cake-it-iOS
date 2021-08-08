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
  
  var notice: Notice?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNotice()
  }
  
  private func configureNotice() {
    titleLabel.text = notice?.title
    textLabel.text = notice?.body
    dateLabel.text = notice?.createdAt
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}
