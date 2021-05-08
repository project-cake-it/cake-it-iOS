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
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListBoardCell
    cell.titleLabel.text = notices[indexPath.row]
    cell.dateLabel.text = "2021.5.11"
    return cell
  }
}
