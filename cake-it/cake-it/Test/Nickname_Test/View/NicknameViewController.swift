//
//  NicknameViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/02/16.
//

import UIKit

class NicknameViewController: BaseViewController {

    @IBOutlet weak var nicknameLabel: UILabel!
    
    var viewModel: NicknameViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = NicknameViewModel()
    }
    
    @IBAction func clickedGetNicknameButton(_ sender: Any) {
        viewModel?.performGetNickname(complition: { randNickname in
            self.nicknameLabel.text = randNickname
        })
    }
}
