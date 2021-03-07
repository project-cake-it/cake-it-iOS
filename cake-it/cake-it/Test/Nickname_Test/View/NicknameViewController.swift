//
//  NicknameViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import UIKit

final class NicknameViewController: BaseViewController {
  
  @IBOutlet weak var nicknameLabel: UILabel!
  
  var viewModel: NicknameViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = NicknameViewModel()
  }
  
  @IBAction func NicknameGetButtonDidTap(_ sender: Any) {
    viewModel?.performGetNickname(completion: { (randNickname) in
      self.nicknameLabel.text = randNickname
    })
  }
}
