//
//  ListBoardViewController+UITableViewDataSource {.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

extension ListBoardViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notices.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = String(describing: ListBoardCell.self)
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ListBoardCell
    
    let notice = notices[indexPath.row]
    cell.updateCell(notice)
    return cell
  }
}
