//
//  InfomationViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

class InfomationViewController: BaseViewController {
  
  @IBOutlet weak var viewTitleLabel: UILabel!
  @IBOutlet weak var infomationTextLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    dismiss(animated: false, completion: nil)
  }
}
