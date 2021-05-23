//
//  FilterDetailView.swift
//  cake-it
//
//  Created by seungbong on 2021/05/23.
//

import UIKit

final class FilterDetailView: UIView {

  @IBOutlet weak var filterTableView: UITableView!
  
  var filterType: FilterCommon.FilterType = .reset {
    didSet {
      registerTableViewCell()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    loadView()
    configureView()
  }
  
  private func loadView() {
    let view = Bundle.main.loadNibNamed(String(describing: FilterDetailView.self),
                                        owner: self,
                                        options: nil)?.first as! UIView
    self.addSubview(view)
  }
  
  private func configureView() {
    filterTableView.delegate = self
    filterTableView.dataSource = self
  }
  
  private func registerTableViewCell() {
    var identifier: String = ""
    switch filterType {
    case .basic, .category, .region:
      identifier = String(describing: FilterBasicCell.self)
    case .color:
      identifier = String(describing: FilterColorCell.self)
    case .size:
      identifier = String(describing: FilterDescriptionCell.self)
    default: break
    }
    
    if identifier.isEmpty == false {
      let nib = UINib(nibName: identifier, bundle: nil)
      filterTableView.register(nib, forCellReuseIdentifier: identifier)
    }
  }
}

extension FilterDetailView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return FilterCommon.numberOfMemebers(type: filterType)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch filterType {
    case .basic:
      let identifier = String(describing: FilterBasicCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterBasicCell {
        let filterInfo = FilterCommon.FilterBasic.allCases[indexPath.row]
        cell.update(title: filterInfo.title)
        return cell
      }
    case .region:
      let identifier = String(describing: FilterBasicCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterBasicCell {
        let filterInfo = FilterCommon.FilterRegion.allCases[indexPath.row]
        cell.update(title: filterInfo.title)
        return cell
      }
    case .category:
      let identifier = String(describing: FilterBasicCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterBasicCell {
        let filterInfo = FilterCommon.FilterCategory.allCases[indexPath.row]
        cell.update(title: filterInfo.title)
        return cell
      }
    case .size:
      let identifier = String(describing: FilterDescriptionCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterDescriptionCell {
        let filterInfo = FilterCommon.FilterSize.allCases[indexPath.row]
        cell.update(title: filterInfo.title, description: filterInfo.description)
        return cell
      }
    case .color:
      let identifier = String(describing: FilterColorCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterColorCell {
        let filterInfo = FilterCommon.FilterColor.allCases[indexPath.row]
        cell.update(title: filterInfo.title, color: filterInfo.color)
        return cell
      }
    default:
      break
    }
    return FilterBasicCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
  }
}
