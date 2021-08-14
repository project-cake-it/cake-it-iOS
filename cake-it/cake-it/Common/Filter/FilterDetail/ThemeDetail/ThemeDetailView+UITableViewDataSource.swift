//
//  ThemeDetailView+UITableViewDataSource.swift
//  cake-it
//
//  Created by seungbong on 2021/06/20.
//

import UIKit

extension ThemeDetailView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return FilterCommon.FilterTheme.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      resetData()
    }
    
    let identifier = String(describing: CakeDesignThemeCell.self)
    if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CakeDesignThemeCell {
      let themeType = FilterCommon.FilterTheme.allCases[indexPath.row]
      cell.themeLabel.text = themeType.title
      if selectedTheme == themeType {
        cell.themeLabel.textColor = Colors.primaryColor
        cell.themeLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 14.0)
      }
      return cell
    }
    return UITableViewCell()
  }
  
}
