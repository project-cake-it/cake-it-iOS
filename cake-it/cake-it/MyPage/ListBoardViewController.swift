//
//  CommonBoardListViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

final class ListBoardViewController: BaseViewController {
  
  enum Metric {
    static let listHeight: CGFloat = 67.0
  }
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var listTableView: UITableView!
  
  private(set) var notices: [Notice] = []
  private let viewModel: MyPageViewModel = MyPageViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTavleView()
    fetchNotices()
    navigationController?.navigationBar.isHidden = true
  }
  
  private func configureTavleView() {
    listTableView.delegate = self
    listTableView.dataSource = self
  }
  
  private func fetchNotices() {
    viewModel.requestNotices { success, result, error in
      if success {
        guard let result = result else { return }
        self.notices = result
        self.listTableView.reloadData()
      } else {
        // TODO: error 처리
      }
    }
    listTableView.reloadData()
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}
