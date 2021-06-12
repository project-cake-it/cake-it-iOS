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
    static let tableViewDefaultHeight: CGFloat = 400.0
    static let headerCellHeight: CGFloat = 38.0
    static let footerCellHeight: CGFloat = 22.0
    static let defaultTableCellHight: CGFloat = 38.0
    static let largeTableCellHight: CGFloat = 59.0
    static let tableViewRadius: CGFloat = 16.0
  }
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var filterTableView: UITableView!
  var filterTableViewHeightConstraint: NSLayoutConstraint?
  
  weak var delegate: FilterDetailViewDelegate?
  var filterType: FilterCommon.FilterType = .reset {
    didSet {
      registerCell()
    }
  }
  var selectedList: [String] = []   // 해당 filterType에 선택된 필터 리스트
  var tableViewHeight: CGFloat = 0.0
  
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
    filterTableView.separatorStyle = .none
    filterTableView.round(cornerRadius: Metric.tableViewRadius,
                          maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
    
    settingConstraint()

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewDidTap))
    backgroundView.addGestureRecognizer(tapGesture)
  }
  
  private func settingConstraint() {
    backgroundView.constraints(topAnchor: self.topAnchor,
                               leadingAnchor: self.leadingAnchor,
                               bottomAnchor: self.bottomAnchor,
                               trailingAnchor: self.trailingAnchor)

    filterTableView.constraints(topAnchor: self.topAnchor,
                                leadingAnchor: self.leadingAnchor,
                                trailingAnchor: self.trailingAnchor)
    filterTableViewHeightConstraint = filterTableView.heightAnchor.constraint(equalToConstant: Metric.tableViewDefaultHeight)
    filterTableViewHeightConstraint?.isActive = true
  }
  
  private func registerCell() {
    registerHeaderCell()
    registerTableCell()
  }
  
  private func registerHeaderCell() {
    let identifier = String(describing: FilterTableHeaderCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    filterTableView.register(nib, forCellReuseIdentifier: identifier)
  }
  
  private func registerTableCell() {
    var identifier: String?
    switch filterType {
    case .basic, .category, .region:
      identifier = String(describing: FilterBasicCell.self)
    case .color:
      identifier = String(describing: FilterColorCell.self)
    case .size:
      identifier = String(describing: FilterDescriptionCell.self)
    default: break
    }
    
    if let id = identifier {
      let nib = UINib(nibName: id, bundle: nil)
      filterTableView.register(nib, forCellReuseIdentifier: id)
    }
  }
  
  func resetData() {
    tableViewHeight = 0.0
  }
  
  @objc private func backgroundViewDidTap() {
    delegate?.backgroundViewDidTap()
    
    for subView in self.subviews {
      subView.removeFromSuperview()
    }
    self.removeFromSuperview()
  }
  
  func updateSelectedList(selectedIndex: Int = 0,
                          isAllSelected: Bool = false,
                          isAllDeselected: Bool = false) {
    if isAllSelected {
      selectedList.removeAll()
      let allValues = FilterManager.shared.allValuesOfCase(type: filterType)
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
        if FilterManager.shared.isMultiSelectionEnabled(type: filterType) == false {
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
    case .basic:    return FilterCommon.FilterSorting.allCases[index].value
    case .region:   return FilterCommon.FilterRegion.allCases[index].value
    case .size:     return FilterCommon.FilterSize.allCases[index].value
    case .color:    return FilterCommon.FilterColor.allCases[index].value
    case .category: return FilterCommon.FilterCategory.allCases[index].value
    case .reset:    return ""
    }
  }
}

extension FilterDetailView: FilterTableHeaderCellDelegate {
  // 전체 선택 처리
  func headerCellDidTap(isSelected: Bool) {
    if isSelected {
      updateSelectedList(isAllSelected: true)
    } else {
      updateSelectedList(isAllDeselected: true)
    }
  }
}
