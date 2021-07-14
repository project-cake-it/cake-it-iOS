//
//  ListBoardCell.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit

final class ListBoardCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func updateCell(_ notice:Notice) {
    titleLabel.text = notice.title
    dateLabel.text = notice.createdAt
  }
}
