//
//  FilterDetailViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/07/18.
//

import UIKit

protocol FilterDetailViewDelegate: AnyObject {
  func filterDetailCellDidTap(type: FilterCommon.FilterType, values: [String])
  func filterBackgroundViewDidTap()
}

final class FilterDetailViewController: UIViewController {
  
  enum Metric {
    static let tableViewDefaultHeight: CGFloat = 400.0
    static let headerCellHeight: CGFloat = 40.0
    static let footerCellHeight: CGFloat = 22.0
    static let defaultTableCellHight: CGFloat = 38.0
    static let largeTableCellHight: CGFloat = 59.0
    static let tableViewRadius: CGFloat = 16.0
  }
  
  @IBOutlet var containerView: UIView!
  @IBOutlet weak var filterTableView: UITableView!
  @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var backgroundView: UIView!
  private var pickUpAvailableDateSectionView: UIView!
  
  weak var delegate: FilterDetailViewDelegate?
  var filterType: FilterCommon.FilterType = .reset
  var selectedList: [String] = []   // 해당 filterType에 선택된 필터 리스트
  var containerViewHeight: CGFloat = 0.0 {
    didSet {
      containerViewHeightConstraint?.constant = containerViewHeight
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  func resetData() {
    containerViewHeight = 0.0
  }
  
  @objc private func backgroundViewDidTap() {
    delegate?.filterBackgroundViewDidTap()
  }
  
  func setTableViewHeight() {
    let numberOfCell = FilterManager.shared.numberOfCase(type: filterType)
    let cellHeight = tableCellHeight(type: filterType)
    let headerHeight = Metric.headerCellHeight
    let footerHeight = Metric.footerCellHeight
    let isExistHeader = FilterManager.shared.isMultiSelectionEnabled(type: filterType)

    containerViewHeight = 0
    view.layoutIfNeeded()
    guard filterType != .reset else { return }
    
    if isExistHeader {
      containerViewHeight = headerHeight + (CGFloat(numberOfCell) * cellHeight) + footerHeight
    } else {
      containerViewHeight = (CGFloat(numberOfCell) * cellHeight) + footerHeight
    }
    UIView.animateCurveEaseOut(withDuration: 0.25, delay: 0.05) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
  
  func tableCellHeight(type: FilterCommon.FilterType) -> CGFloat {
    if filterType == .size {
      return Metric.largeTableCellHight
    } else {
      return Metric.defaultTableCellHight
    }
  }
}

// MARK:- Filter Method
extension FilterDetailViewController {
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
    
    delegate?.filterDetailCellDidTap(type: filterType, values: selectedList)
    filterTableView.reloadData()
  }
  
  private func selectedFilterTitle( index: Int) -> String {
    switch filterType {
    case .order:    return FilterCommon.FilterSorting.allCases[index].value
    case .region:   return FilterCommon.FilterRegion.allCases[index].value
    case .size:     return FilterCommon.FilterSize.allCases[index].value
    case .color:    return FilterCommon.FilterColor.allCases[index].value
    case .category: return FilterCommon.FilterCategory.allCases[index].value
    // TODO: 선택한 날짜 Value 리턴 구현 필요 (현재 서버 미구현)
    case .pickupDate: return ""
    case .reset:    return ""
    }
  }
}

// MARK:- 테이블 헤더셀 전체선택 처리
extension FilterDetailViewController: FilterTableHeaderCellDelegate {
  func headerCellDidTap(isSelected: Bool) {
    if isSelected {
      updateSelectedList(isAllSelected: true)
    } else {
      updateSelectedList(isAllDeselected: true)
    }
  }
}

// MARK: - Configuration

extension FilterDetailViewController {
  private func configure() {
    configureView()
    configureContainerView()
  }
  
  private func configureView() {
    filterTableView.delegate = self
    filterTableView.dataSource = self
    filterTableView.separatorStyle = .none
    registerCell()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewDidTap))
    backgroundView.addGestureRecognizer(tapGesture)
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
    var identifiers: [String] = []
    identifiers.append(String(describing: FilterBasicCell.self))
    identifiers.append(String(describing: FilterColorCell.self))
    identifiers.append(String(describing: FilterDescriptionCell.self))
    
    for id in identifiers {
      let nib = UINib(nibName: id, bundle: nil)
      filterTableView.register(nib, forCellReuseIdentifier: id)
    }
  }
  
  private func configureContainerView() {
    containerView.round(cornerRadius: Metric.tableViewRadius,
                        maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
    containerView.clipsToBounds = true
  }
}
