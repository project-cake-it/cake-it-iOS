//
//  ShopDetailAvailableDateViewController.swift
//  cake-it
//
//  Created by Cory on 2021/08/01.
//

import UIKit

final class ShopDetailAvailableDateViewController: UIViewController {
  
  private enum Metric {
    static let sidePadding: CGFloat = 16.0
  }
  
  private var backgroundDismissTapView: UIView!
  private var containerView: UIView!
  private var titleLabel: UILabel!
  private var dismissButton: UIButton!
  private var currentYearMonthLabel: UILabel!
  private var previousMonthButton: UIButton!
  private var nextMonthButton: UIButton!
  private var weekdayTitleLabelStackView: UIStackView!
  private var collectionView: UICollectionView!
  private var collectionViewHeightConstraint: NSLayoutConstraint!
  
  private var hasAppearingAnimated = false
  
  private var availableDates: [CakeOrderAvailableDate] = []
  
  static let numberOfDaysByMonth: [Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  /// 현재 달부터 최대 달
  private var maxMonthOffset: Int = 1
  
  private(set) var totalOrderDates: [CakeOrderAvailableDates] = []
  private(set) var currentMonthIndex: Int = 0 {
    didSet {
      collectionView.reloadData()
      updateCollectionViewHeightToItsHeight()
      updateCurrentYearMonthLabel()
      updateChangeMonthButtonState()
    }
  }
  
  init(availableDates: [String]) {
    super.init(nibName: nil, bundle: nil)
    self.availableDates = availableDates.map {
      DateFormatter.CakeOrderAvailableDateFormatter.date(from: $0)
    }.compactMap { $0 }.filter {
      $0 >= Date()
    }.map {
      CakeOrderAvailableDate(date: $0)
    }
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard hasAppearingAnimated == false else { return }
    
    showBackgroundView()
  }
  
  private func configureDateDatas() {
    let currentDate = CakeOrderAvailableDate(date: Date())
//    let minDateDayOffset = currentDate.hour >= 18 ? 2 : 1
    let minDateDayOffset = 1
    let minDate = currentDate.after(dayOffset: minDateDayOffset)
    let maxDate = currentDate.after(dayOffset: 30)
    maxMonthOffset = maxDate.month - minDate.month
    
    for offset in 0...maxMonthOffset {
      let monthUpdatedDate = minDate.after(monthOffset: offset)
      var datesByMonth = CakeOrderAvailableDates()
      for day in 1...ShopDetailAvailableDateViewController.numberOfDaysByMonth[monthUpdatedDate.month] {
        var dayDate = CakeOrderAvailableDate(
          year: monthUpdatedDate.year,
          month: monthUpdatedDate.month,
          day: day)
        if dayDate >= minDate && dayDate <= maxDate {
          availableDates.forEach {
            if dayDate == $0 {
              dayDate.enabled()
            }
          }
        }
        datesByMonth.append(dayDate)
      }
      datesByMonth.configureFirstDayOffsetDates()
      totalOrderDates.append(datesByMonth)
    }
    collectionView.reloadData()
    updateCollectionViewHeightToItsHeight()
  }
  
  private func showBackgroundView() {
    UIView.animateCurveEaseOut(withDuration: 0.25) {
      self.view.backgroundColor = UIColor(displayP3Red: 00, green: 0, blue: 0, alpha: 0.4)
    } completion: {
      self.showContainerView()
      self.hasAppearingAnimated = true
      self.configureBackgroundViewTapGesture()
    }
  }
  
  private func showContainerView() {
    containerView.transform = CGAffineTransform(translationX: 0, y: 120)
    UIView.animateCurveEaseOut(withDuration: 0.2) {
      self.containerView.alpha = 1
      self.containerView.transform = .identity
    } completion: {
      
    }
  }
  
  private func configureBackgroundViewTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewDidTap))
    backgroundDismissTapView.addGestureRecognizer(tapGesture)
  }
  
  @objc private func backgroundViewDidTap() {
    dismiss()
  }
  
  @objc private func dismissButtonDidTap() {
    dismiss()
  }
  
  @objc private func previousMonthButtonDidTap() {
    currentMonthIndex = max(0, currentMonthIndex - 1)
  }
  
  @objc private func nextMonthButtonDidTap() {
    currentMonthIndex = min(maxMonthOffset, currentMonthIndex + 1)
  }
  
  private func dismiss() {
    UIView.animateCurveEaseOut(withDuration: 0.15) {
      self.containerView.alpha = 0
      self.view.backgroundColor = UIColor(displayP3Red: 00, green: 0, blue: 0, alpha: 0)
    } completion: {
      self.dismiss(animated: false, completion: nil)
    }
  }
  
  private func updateCurrentYearMonthLabel() {
    let currentDate = CakeOrderAvailableDate(date: Date())
    let newDate = currentDate.after(monthOffset: currentMonthIndex)
    currentYearMonthLabel.text = "\(newDate.year)년 \(newDate.month)월"
  }
  
  private func updateChangeMonthButtonState() {
    previousMonthButton.isEnabled = currentMonthIndex != 0
    previousMonthButton.tintColor = previousMonthButton.isEnabled ?
      Colors.pointB : Colors.grayscale03
    nextMonthButton.isEnabled = currentMonthIndex != maxMonthOffset
    nextMonthButton.tintColor = nextMonthButton.isEnabled ?
      Colors.pointB : Colors.grayscale03
  }
}

// MARK: - Configuration

extension ShopDetailAvailableDateViewController {
  
  private func configure() {
    configureView()
    configureBackgroundDismissTapView()
    configureContainerView()
    configureTitleLabel()
    configureDismissButton()
    configureCurrentYearMonthLabel()
    configureArrowButtons()
    configureWeekdayTitleLabelStackView()
    configureCollectionView()
    registerCollectionViewCell()
    configureDateDatas()
    updateCurrentYearMonthLabel()
  }
  
  private func configureView() {
    view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
  }
  
  private func configureBackgroundDismissTapView() {
    backgroundDismissTapView = UIView()
    backgroundDismissTapView.backgroundColor = .clear
    view.addSubview(backgroundDismissTapView)
    backgroundDismissTapView.fillSuperView()
  }
  
  private func configureContainerView() {
    containerView = UIView()
    containerView.backgroundColor = Colors.grayscale01
    containerView.alpha = 0
    containerView.round(cornerRadius: 16)
    view.addSubview(containerView)
    containerView.constraints(topAnchor: nil,
                              leadingAnchor: view.leadingAnchor,
                              bottomAnchor: nil,
                              trailingAnchor: view.trailingAnchor,
                              padding: .init(top: 0,
                                             left: Metric.sidePadding,
                                             bottom: 0,
                                             right: Metric.sidePadding))
    containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  private func configureTitleLabel() {
    titleLabel = UILabel()
    titleLabel.text = "주문 가능 날짜"
    titleLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 15)
    containerView.addSubview(titleLabel)
    titleLabel.constraints(topAnchor: containerView.topAnchor,
                           leadingAnchor: nil,
                           bottomAnchor: nil,
                           trailingAnchor: nil,
                           padding: .init(top: 16, left: 0, bottom: 0, right: 0),
                           size: .init(width: 0, height: 24))
    titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
  }
  
  private func configureDismissButton() {
    dismissButton = UIButton(type: .system)
    dismissButton.setImage(#imageLiteral(resourceName: "icDismiss"), for: .normal)
    dismissButton.tintColor = Colors.black
    containerView.addSubview(dismissButton)
    dismissButton.constraints(topAnchor: containerView.topAnchor,
                              leadingAnchor: nil,
                              bottomAnchor: nil,
                              trailingAnchor: containerView.trailingAnchor,
                              padding: .init(top: 8, left: 0, bottom: 0, right: 12),
                              size: .init(width: 38, height: 38))
    dismissButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
  }
  
  private func configureCurrentYearMonthLabel() {
    currentYearMonthLabel = UILabel()
    currentYearMonthLabel.text = "0000년 0월"
    currentYearMonthLabel.font = Fonts.spoqaHanSans(weight: .Bold, size: 20)
    containerView.addSubview(currentYearMonthLabel)
    currentYearMonthLabel.constraints(topAnchor: titleLabel.bottomAnchor,
                                      leadingAnchor: containerView.leadingAnchor,
                                      bottomAnchor: nil,
                                      trailingAnchor: nil,
                                      padding: .init(top: 28, left: 16, bottom: 0, right: 0),
                                      size: .init(width: 0, height: 24))
  }
  
  private func configureArrowButtons() {
    nextMonthButton = UIButton(type: .system)
    nextMonthButton.setImage(#imageLiteral(resourceName: "icChevronCalendarRight"), for: .normal)
    nextMonthButton.tintColor = Colors.pointB
    containerView.addSubview(nextMonthButton)
    nextMonthButton.constraints(topAnchor: dismissButton.bottomAnchor,
                                leadingAnchor: nil,
                                bottomAnchor: nil,
                                trailingAnchor: containerView.trailingAnchor,
                                padding: .init(top: 16, left: 0, bottom: 0, right: 12),
                                size: .init(width: 33, height: 33))
    nextMonthButton.addTarget(self, action: #selector(nextMonthButtonDidTap), for: .touchUpInside)
    
    previousMonthButton = UIButton(type: .system)
    previousMonthButton.setImage(#imageLiteral(resourceName: "icChevronCalendarLeft"), for: .normal)
    previousMonthButton.isEnabled = false
    previousMonthButton.tintColor = Colors.grayscale03
    containerView.addSubview(previousMonthButton)
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
    containerView.addSubview(weekdayTitleLabelStackView)
    weekdayTitleLabelStackView.constraints(topAnchor: currentYearMonthLabel.bottomAnchor,
                          leadingAnchor: containerView.leadingAnchor,
                          bottomAnchor: nil,
                          trailingAnchor: containerView.trailingAnchor,
                          padding: .init(top: 14, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 18))
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    collectionView.delegate = self
    containerView.addSubview(collectionView)
    collectionView.constraints(topAnchor: weekdayTitleLabelStackView.bottomAnchor,
                               leadingAnchor: containerView.leadingAnchor,
                               bottomAnchor: containerView.bottomAnchor,
                               trailingAnchor: containerView.trailingAnchor,
                               padding: .init(top: 12, left: 0, bottom: 32, right: 0))
    collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 260)
    collectionViewHeightConstraint.isActive = true
  }
  
  private func registerCollectionViewCell() {
    let nibName = String(describing: CakeOrderAvailableDateCell.self)
    let nib = UINib(nibName: nibName, bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: nibName)
  }
  
  private func updateCollectionViewHeightToItsHeight() {
    view.layoutIfNeeded()
    let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
    collectionViewHeightConstraint.constant = contentHeight
    collectionViewHeightConstraint.priority = .required
    collectionViewHeightConstraint.isActive = true
  }
}
