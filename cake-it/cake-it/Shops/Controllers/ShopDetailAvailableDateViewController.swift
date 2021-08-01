//
//  ShopDetailAvailableDateViewController.swift
//  cake-it
//
//  Created by Cory on 2021/08/01.
//

import UIKit

final class ShopDetailAvailableDateViewController: UIViewController {
  
  private var containerView: UIView!
  private var titleLabel: UILabel!
  private var dismissButton: UIButton!
  private var currentYearMonthLabel: UILabel!
  private var previousMonthButton: UIButton!
  private var nextMonthButton: UIButton!
  private var weekdayTitleLabelStackView: UIStackView!
  private var collectionView: UICollectionView!
  
  private var hasAppearingAnimated = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard hasAppearingAnimated == false else { return }
    
    showBackgroundView()
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
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func backgroundViewDidTap() {
    UIView.animateCurveEaseOut(withDuration: 0.15) {
      self.containerView.alpha = 0
      self.view.backgroundColor = UIColor(displayP3Red: 00, green: 0, blue: 0, alpha: 0)
    } completion: {
      self.dismiss(animated: false, completion: nil)
    }
  }
}

// MARK: - Configuration

extension ShopDetailAvailableDateViewController {
  
  private func configure() {
    configureView()
    configureContainerView()
    configureTitleLabel()
    configureCurrentYearMonthLabel()
    configureArrowButtons()
    configureWeekdayTitleLabelStackView()
    configureCollectionView()
  }
  
  private func configureView() {
    view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
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
                              trailingAnchor: view.trailingAnchor)
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
    previousMonthButton = UIButton(type: .system)
    previousMonthButton.setImage(#imageLiteral(resourceName: "icChevronCompactRight-blue"), for: .normal)
    
  }
  
  private func configureWeekdayTitleLabelStackView() {
    weekdayTitleLabelStackView = UIStackView()
    weekdayTitleLabelStackView.distribution = .fillEqually
    weekdayTitleLabelStackView.axis = .horizontal
    let weekdayTitles = ["월", "화", "수", "목", "금", "토", "일"]
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
    collectionView.backgroundColor = .yellow
    containerView.addSubview(collectionView)
    collectionView.constraints(topAnchor: weekdayTitleLabelStackView.bottomAnchor,
                               leadingAnchor: containerView.leadingAnchor,
                               bottomAnchor: containerView.bottomAnchor,
                               trailingAnchor: containerView.trailingAnchor,
                               padding: .init(top: 12, left: 0, bottom: 32, right: 0),
                               size: .init(width: 0, height: 260))
  }
}
