//
//  FilterDetailView+UITableViewDataSource.swift
//  cake-it
//
//  Created by seungbong on 2021/05/30.
//

import UIKit

extension FilterDetailView: UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch filterType {
    case .basic:
      let identifier = String(describing: FilterBasicCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterBasicCell {
        let filterInfo = FilterCommon.FilterSorting.allCases[indexPath.row]
        cell.isCellSelected = selectedList.contains(filterInfo.title)
        cell.update(title: filterInfo.title)
        cell.selectionStyle = .none
        return cell
      }
    case .region:
      let identifier = String(describing: FilterBasicCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterBasicCell {
        let filterInfo = FilterCommon.FilterRegion.allCases[indexPath.row]
        cell.isCellSelected = selectedList.contains(filterInfo.title)
        cell.update(title: filterInfo.title)
        cell.selectionStyle = .none
        return cell
      }
    case .category:
      let identifier = String(describing: FilterBasicCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterBasicCell {
        let filterInfo = FilterCommon.FilterCategory.allCases[indexPath.row]
        cell.isCellSelected = selectedList.contains(filterInfo.title)
        cell.update(title: filterInfo.title)
        cell.selectionStyle = .none
        return cell
      }
    case .size:
      let identifier = String(describing: FilterDescriptionCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterDescriptionCell {
        let filterInfo = FilterCommon.FilterSize.allCases[indexPath.row]
        cell.isCellSelected = selectedList.contains(filterInfo.title)
        cell.update(title: filterInfo.title, description: filterInfo.description)
        cell.selectionStyle = .none
        return cell
      }
    case .color:
      let identifier = String(describing: FilterColorCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterColorCell {
        let filterInfo = FilterCommon.FilterColor.allCases[indexPath.row]
        cell.isCellSelected = selectedList.contains(filterInfo.title)
        cell.update(title: filterInfo.title, color: filterInfo.color)
        cell.selectionStyle = .none
        return cell
      }
    default:
      break
    }
    
    return UITableViewCell()
  }
}
