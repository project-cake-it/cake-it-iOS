//
//  FilterDetailView.swift
//  cake-it
//
//  Created by seungbong on 2021/05/23.
//

import UIKit

protocol FilterDetailViewDelegate: class {
  func filterDetailCellDidTap(key: FilterCommon.FilterType, values: [String])
  func backgroundViewDidTap()
}

final class FilterDetailView: UIView {

  enum Metric {
    static let headerCellHeight: CGFloat = 38.0
    static let footerCellHeight: CGFloat = 22.0
  }
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var filterTableView: UITableView!
  
  weak var delegate: FilterDetailViewDelegate?
  var selectedList: [String] = [] // 해당 filterType에 선택된 필터 리스트
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
    filterTableView.round(cornerRadius: 10,
                          maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewDidTap))
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
  
  @objc private func backgroundViewDidTap() {
    delegate?.backgroundViewDidTap()
    
    for subView in self.subviews {
      subView.removeFromSuperview()
    }
    self.removeFromSuperview()
  }
  
  private func updateSelectedList(selectedIndex: Int = 0,
                                  isAllSelected: Bool = false,
                                  isAllDeselected: Bool = false) {
    if isAllSelected {
      selectedList.removeAll()
      let allValues = FilterCommon.allValuesOfCase(type: filterType)
      for value in allValues {
        selectedList.append(value)
      }
    } else if isAllDeselected {
      selectedList.removeAll()
    } else {
      let value = selectedFilterTitle(index: selectedIndex)
      if selectedList.contains(value) {
        // 이미 존재하는 값일 경우에는 선택 취소
        let index = selectedList.firstIndex(of: value)!
        selectedList.remove(at: index)
      } else {
        // 단일선택인 경우 기존 리스트 값 제거 후 해당 필터만 추가
        if filterType.enableMuliSelection == false {
          selectedList.removeAll()
        }
        selectedList.append(value)
      }
    }
    
    delegate?.filterDetailCellDidTap(key: filterType, values: selectedList)
    
    filterTableView.reloadData()
  }
  
  private func selectedFilterTitle( index: Int) -> String {
    switch filterType {
    case .basic:    return FilterCommon.FilterBasic.allCases[index].title
    case .region:   return FilterCommon.FilterRegion.allCases[index].title
    case .size:     return FilterCommon.FilterSize.allCases[index].title
    case .color:    return FilterCommon.FilterColor.allCases[index].title
    case .category: return FilterCommon.FilterCategory.allCases[index].title
    case .reset:    return ""
    }
  }
}

extension FilterDetailView: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return FilterCommon.numberOfCase(type: filterType)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch filterType {
    case .basic:
      let identifier = String(describing: FilterBasicCell.self)
      if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FilterBasicCell {
        let filterInfo = FilterCommon.FilterBasic.allCases[indexPath.row]
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    updateSelectedList(selectedIndex: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if filterType.enableMuliSelection == true {
      let headerCell = FilterDetailViewHeaderCell()
      if selectedList.count == FilterCommon.numberOfCase(type: filterType) {
        headerCell.isCellSelected = true
      }
      headerCell.delegate = self
      return headerCell
    }
    return nil
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    footerView.backgroundColor = Colors.grayscale01
    return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if filterType.enableMuliSelection == true {
      return Metric.headerCellHeight
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return Metric.footerCellHeight
  }
}

extension FilterDetailView: FilterDetailViewHeaderCellDelegate {
  // 전체 선택 처리
  func headerCellDidTap(isSelected: Bool) {
    if isSelected {
      updateSelectedList(isAllSelected: true)
    } else {
      updateSelectedList(isAllDeselected: true)
    }
  }
}
