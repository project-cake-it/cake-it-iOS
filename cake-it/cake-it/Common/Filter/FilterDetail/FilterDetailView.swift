//
//  FilterDetailView.swift
//  cake-it
//
//  Created by seungbong on 2021/05/23.
//

import UIKit

protocol FilterDetailViewDelegate: class {
  func filterDetailCellDidTap(key: FilterCommon.FilterType, value: String)
  func resetFilterView()
}

final class FilterDetailView: UIView {

  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var filterTableView: UITableView!
  
  weak var delegate: FilterDetailViewDelegate?
  var selectedFilterDic: [String: [String]] = [:]
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
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapGesture))
    backgroundView.addGestureRecognizer(tapGesture)
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
  
  @objc private func didTapGesture() {
    delegate?.resetFilterView()
    self.removeFromSuperview()
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
        let isCellSelected = selectedFilterDic[filterType.title]?.contains(filterInfo.title) ?? false
        cell.update(title: filterInfo.title)
        cell.isCellSelected = isCellSelected
        cell.selectionStyle = .none
        return cell
      }
    case .region:
      let identifier = String(describing: FilterBasicCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterBasicCell {
        let filterInfo = FilterCommon.FilterRegion.allCases[indexPath.row]
        let isCellSelected = selectedFilterDic[filterType.title]?.contains(filterInfo.title) ?? false
        cell.update(title: filterInfo.title)
        cell.isCellSelected = isCellSelected
        cell.selectionStyle = .none
        return cell
      }
    case .category:
      let identifier = String(describing: FilterBasicCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterBasicCell {
        let filterInfo = FilterCommon.FilterCategory.allCases[indexPath.row]
        let isCellSelected = selectedFilterDic[filterType.title]?.contains(filterInfo.title) ?? false
        cell.update(title: filterInfo.title)
        cell.isCellSelected = isCellSelected
        cell.selectionStyle = .none
        return cell
      }
    case .size:
      let identifier = String(describing: FilterDescriptionCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterDescriptionCell {
        let filterInfo = FilterCommon.FilterSize.allCases[indexPath.row]
        let isCellSelected = selectedFilterDic[filterType.title]?.contains(filterInfo.title) ?? false
        cell.update(title: filterInfo.title, description: filterInfo.description)
        cell.isCellSelected = isCellSelected
        cell.selectionStyle = .none
        return cell
      }
    case .color:
      let identifier = String(describing: FilterColorCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterColorCell {
        let filterInfo = FilterCommon.FilterColor.allCases[indexPath.row]
        let isCellSelected = selectedFilterDic[filterType.title]?.contains(filterInfo.title) ?? false
        cell.update(title: filterInfo.title, color: filterInfo.color)
        cell.isCellSelected = isCellSelected
        cell.selectionStyle = .none
        return cell
      }
    default:
      break
    }
    return FilterBasicCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    var value: String = ""
    switch filterType {
    case .basic:
      value = FilterCommon.FilterBasic.allCases[indexPath.row].title
    case .region:
      value = FilterCommon.FilterRegion.allCases[indexPath.row].title
    case .size:
      value = FilterCommon.FilterSize.allCases[indexPath.row].title
    case .color:
      value = FilterCommon.FilterColor.allCases[indexPath.row].title
    case .category:
      value = FilterCommon.FilterCategory.allCases[indexPath.row].title
    case .reset:
      break
    }
    
    delegate?.filterDetailCellDidTap(key: filterType, value: value)
  }
}
