//
//  FilterDetailViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/07/18.
//

import UIKit

protocol FilterDetailViewControllerDelegate: AnyObject {
  func filterDetailCellDidTap(type: FilterCommon.FilterType, values: [String])
  func filterDetailViewController(_ dismissFilterDetailViewController: FilterDetailViewController, delay: TimeInterval)
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
  @IBOutlet var containerViewHeightConstraintForPickUpDate: NSLayoutConstraint!
  @IBOutlet var containerViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var backgroundView: UIView!
  private var pickUpAvailableDateSectionView: UIView!
  private var currentYearMonthLabel: UILabel!
  private var previousMonthButton: UIButton!
  private var nextMonthButton: UIButton!
  private var weekdayTitleLabelStackView: UIStackView!
  private(set) var pickUpCalendarCollectionView: UICollectionView!
  private var collectionViewHeightConstraint: NSLayoutConstraint!
  
  weak var delegate: FilterDetailViewControllerDelegate?
  var filterType: FilterCommon.FilterType = .reset
  var selectedList: [String] = []   // 해당 filterType에 선택된 필터 리스트
  var containerViewHeight: CGFloat = 0.0 {
    didSet {
      containerViewHeightConstraint.constant = containerViewHeight
    }
  }
  
  static let numberOfDaysByMonth: [Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  /// 현재 달부터 최대 달
  private var maxMonthOffset: Int = 1
  
  private(set) var totalPickUpAvailableDates: [CakeOrderAvailableDates] = []
  private(set) var currentMonthIndex: Int = 0 {
    didSet {
      pickUpCalendarCollectionView.reloadData()
      updateCollectionViewHeightToItsHeight()
      updateCurrentYearMonthLabel()
      updateChangeMonthButtonState()
    }
  }
  var selectedPickUpDate: CakeOrderAvailableDate? {
    didSet {
      pickUpCalendarCollectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  func updateViewForPickUpDate() {
    pickUpAvailableDateSectionView.isHidden = false
    configurePickUpAvailableDateData()
    updateCurrentYearMonthLabel()
    updateChangeMonthButtonState()
    
    containerViewHeightConstraint.isActive = true
    containerViewHeightConstraintForPickUpDate.isActive = false
    containerViewHeight = 0
    view.layoutIfNeeded()
    
    containerViewHeightConstraint.isActive = false
    containerViewHeightConstraintForPickUpDate.isActive = true
    let contentHeight = pickUpCalendarCollectionView.collectionViewLayout.collectionViewContentSize.height
    collectionViewHeightConstraint.constant = contentHeight
    UIView.animateCurveEaseOut(withDuration: 0.25, delay: 0.05) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
  
  func resetSelectedPickUpDate() {
    selectedPickUpDate = nil
  }
  
  func hidePickUpDateSectionView() {
    pickUpAvailableDateSectionView.isHidden = true
  }
  
  func resetData() {
    containerViewHeight = 0.0
  }
  
  func setTableViewHeight() {
    containerViewHeightConstraint.isActive = true
    containerViewHeightConstraintForPickUpDate.isActive = false
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
  
  @objc private func backgroundViewDidTap() {
    delegate?.filterDetailViewController(self, delay: 0)
  }
  
  func tableCellHeight(type: FilterCommon.FilterType) -> CGFloat {
    if filterType == .size {
      return Metric.largeTableCellHight
    } else {
      return Metric.defaultTableCellHight
    }
  }
}

// MARK: - Pick Up Calendar

extension FilterDetailViewController {
  private func configurePickUpAvailableDateData() {
    let currentDate = CakeOrderAvailableDate(date: Date())
    let minDateDayOffset = currentDate.hour >= 18 ? 2 : 1
    let minDate = currentDate.after(dayOffset: minDateDayOffset)
    let maxDate = currentDate.after(dayOffset: 30)
    maxMonthOffset = maxDate.month - minDate.month
    
    for offset in 0...maxMonthOffset {
      let monthUpdatedDate = minDate.after(monthOffset: offset)
      var datesByMonth = CakeOrderAvailableDates()
      for day in 1...FilterDetailViewController.numberOfDaysByMonth[monthUpdatedDate.month] {
        var dayDate = CakeOrderAvailableDate(
          year: monthUpdatedDate.year,
          month: monthUpdatedDate.month,
          day: day)
        dayDate.enabled()
        if dayDate < minDate || dayDate > maxDate {
          dayDate.disabled()
        }
        datesByMonth.append(dayDate)
      }
      datesByMonth.configureFirstDayOffsetDates()
      totalPickUpAvailableDates.append(datesByMonth)
    }
    pickUpCalendarCollectionView.reloadData()
  }
  
  private func updateCurrentYearMonthLabel() {
    let currentDate = CakeOrderAvailableDate(date: Date())
    let newDate = currentDate.after(monthOffset: currentMonthIndex)
    currentYearMonthLabel.text = "\(newDate.year)년 \(newDate.month)월"
  }
  
  private func updateChangeMonthButtonState() {
    previousMonthButton.isEnabled = currentMonthIndex != 0
    previousMonthButton.tintColor = previousMonthButton.isEnabled ?
      Colors.primaryColor : Colors.grayscale03
    nextMonthButton.isEnabled = currentMonthIndex != maxMonthOffset
    nextMonthButton.tintColor = nextMonthButton.isEnabled ?
      Colors.primaryColor : Colors.grayscale03
  }
  
  @objc private func previousMonthButtonDidTap() {
    currentMonthIndex = max(0, currentMonthIndex - 1)
  }
  
  @objc private func nextMonthButtonDidTap() {
    currentMonthIndex = min(maxMonthOffset, currentMonthIndex + 1)
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
      delegate?.filterDetailViewController(self, delay: 0)
    } else if isAllDeselected {
      selectedList.removeAll()
      delegate?.filterDetailViewController(self, delay: 0)
    } else {
      let value = selectedFilterTitle(index: selectedIndex)
      if selectedList.contains(value) {
        // 이미 존재하는 값일 경우에는 선택 취소
        let index = selectedList.firstIndex(of: value)!
        selectedList.remove(at: index)
        if !FilterManager.shared.isMultiSelectionEnabled(type: filterType) {
          delegate?.filterDetailViewController(self, delay: 0)
        }
      } else {
        // 단일선택인 경우 기존 리스트 값 제거 후 해당 필터만 추가
        if FilterManager.shared.isMultiSelectionEnabled(type: filterType) == false {
          selectedList.removeAll()
        }
        selectedList.append(value)
        if !FilterManager.shared.isMultiSelectionEnabled(type: filterType) {
          delegate?.filterDetailViewController(self, delay: 0)
        }
      }
      if value == "resetPickUpDate" {
        selectedList.removeAll()
      }
    }
    
    delegate?.filterDetailCellDidTap(type: filterType, values: selectedList)
    filterTableView.reloadData()
  }
  
  private func selectedFilterTitle(index: Int) -> String {
    switch filterType {
    case .order:    return FilterCommon.FilterSorting.allCases[index].value
    case .region:   return FilterCommon.FilterRegion.allCases[index].value
    case .size:     return FilterCommon.FilterSize.allCases[index].value
    case .color:    return FilterCommon.FilterColor.allCases[index].value
    case .category: return FilterCommon.FilterCategory.allCases[index].value
    // TODO: 선택한 날짜 Value 리턴 구현 필요 (현재 서버 미구현)
    case .pickupDate:
      guard let selectedPickUpDate = selectedPickUpDate else { return "resetPickUpDate" }
      return DateFormatter.CakeOrderAvailableDateFormatter.string(from: selectedPickUpDate.date)
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
    configurePickUpAvailableDateSectionView()
    configureCurrentYearMonthLabel()
    configureArrowButtons()
    configureWeekdayTitleLabelStackView()
    configureDateCollectionView()
    registerCollectionViewCell()
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
  
  private func configurePickUpAvailableDateSectionView() {
    pickUpAvailableDateSectionView = UIView()
    pickUpAvailableDateSectionView.backgroundColor = .white
    containerView.addSubview(pickUpAvailableDateSectionView)
    pickUpAvailableDateSectionView.fillSuperView()
  }
  
  private func configureCurrentYearMonthLabel() {
    currentYearMonthLabel = UILabel()
    currentYearMonthLabel.text = "0000년 0월"
    currentYearMonthLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 20)
    pickUpAvailableDateSectionView.addSubview(currentYearMonthLabel)
    currentYearMonthLabel.constraints(topAnchor: pickUpAvailableDateSectionView.topAnchor,
                                      leadingAnchor: pickUpAvailableDateSectionView.leadingAnchor,
                                      bottomAnchor: nil,
                                      trailingAnchor: nil,
                                      padding: .init(top: 28, left: 16, bottom: 0, right: 0),
                                      size: .init(width: 0, height: 24))
  }
  
  private func configureArrowButtons() {
    nextMonthButton = UIButton(type: .system)
    nextMonthButton.setImage(#imageLiteral(resourceName: "icChevronCalendarRight"), for: .normal)
    nextMonthButton.tintColor = Colors.primaryColor
    pickUpAvailableDateSectionView.addSubview(nextMonthButton)
    nextMonthButton.constraints(topAnchor: pickUpAvailableDateSectionView.topAnchor,
                                leadingAnchor: nil,
                                bottomAnchor: nil,
                                trailingAnchor: pickUpAvailableDateSectionView.trailingAnchor,
                                padding: .init(top: 16, left: 0, bottom: 0, right: 12),
                                size: .init(width: 33, height: 33))
    nextMonthButton.addTarget(self, action: #selector(nextMonthButtonDidTap), for: .touchUpInside)
    
    previousMonthButton = UIButton(type: .system)
    previousMonthButton.setImage(#imageLiteral(resourceName: "icChevronCalendarLeft"), for: .normal)
    previousMonthButton.isEnabled = false
    previousMonthButton.tintColor = Colors.grayscale03
    pickUpAvailableDateSectionView.addSubview(previousMonthButton)
    previousMonthButton.constraints(topAnchor: nextMonthButton.topAnchor,
                                    leadingAnchor: nil,
                                    bottomAnchor: nil,
                                    trailingAnchor: nextMonthButton.leadingAnchor,
                                    padding: .init(top: 0, left: 0, bottom: 0, right: 4),
                                    size: .init(width: 33, height: 33))
    previousMonthButton.addTarget(self, action: #selector(previousMonthButtonDidTap), for: .touchUpInside)
  }
  
  private func configureWeekdayTitleLabelStackView() {
    weekdayTitleLabelStackView = UIStackView()
    weekdayTitleLabelStackView.distribution = .fillEqually
    weekdayTitleLabelStackView.axis = .horizontal
    let weekdayTitles = ["일", "월", "화", "수", "목", "금", "토"]
    weekdayTitles.forEach {
      let label = UILabel()
      label.textAlignment = .center
      label.textColor = UIColor(displayP3Red: 60/255, green: 60/255, blue: 67/255, alpha: 0.3)
      label.text = $0
      label.font = Fonts.spoqaHanSans(weight: .Bold, size: 13)
      weekdayTitleLabelStackView.addArrangedSubview(label)
    }
    pickUpAvailableDateSectionView.addSubview(weekdayTitleLabelStackView)
    weekdayTitleLabelStackView.constraints(topAnchor: currentYearMonthLabel.bottomAnchor,
                          leadingAnchor: pickUpAvailableDateSectionView.leadingAnchor,
                          bottomAnchor: nil,
                          trailingAnchor: pickUpAvailableDateSectionView.trailingAnchor,
                          padding: .init(top: 14, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 18))
  }
  
  private func configureDateCollectionView() {
    pickUpCalendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    pickUpCalendarCollectionView.backgroundColor = .clear
    pickUpCalendarCollectionView.dataSource = self
    pickUpCalendarCollectionView.delegate = self
    pickUpAvailableDateSectionView.addSubview(pickUpCalendarCollectionView)
    pickUpCalendarCollectionView.constraints(topAnchor: weekdayTitleLabelStackView.bottomAnchor,
                               leadingAnchor: pickUpAvailableDateSectionView.leadingAnchor,
                               bottomAnchor: pickUpAvailableDateSectionView.bottomAnchor,
                               trailingAnchor: pickUpAvailableDateSectionView.trailingAnchor,
                               padding: .init(top: 12, left: 0, bottom: 16, right: 0))
    collectionViewHeightConstraint = pickUpCalendarCollectionView.heightAnchor.constraint(equalToConstant: 340)
    collectionViewHeightConstraint.isActive = true
  }
  
  private func registerCollectionViewCell() {
    let nibName = String(describing: CakeOrderAvailableDateCell.self)
    let nib = UINib(nibName: nibName, bundle: nil)
    pickUpCalendarCollectionView.register(nib, forCellWithReuseIdentifier: nibName)
  }
  
  private func updateCollectionViewHeightToItsHeight() {
    view.layoutIfNeeded()
    let contentHeight = pickUpCalendarCollectionView.collectionViewLayout.collectionViewContentSize.height
    collectionViewHeightConstraint.constant = contentHeight
    collectionViewHeightConstraint.priority = .required
    collectionViewHeightConstraint.isActive = true
    UIView.animateCurveEaseOut(withDuration: 0.25, delay: 0.05) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
}
