//
//  CommonBoardListViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

class ListBoardViewController: BaseViewController {
  
  @IBOutlet weak var backButton: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var listTableView: UITableView!
  
  private(set) var notices: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTavleView()
    fetchNotices()
  }
  
  private func configureTavleView() {
    //listTableView.delegate = self
    listTableView.dataSource = self
  }
  
  private func fetchNotices() {
    for _ in 0..<20 {
      notices.append("공지사항")
    }
    listTableView.reloadData();
  }
}
