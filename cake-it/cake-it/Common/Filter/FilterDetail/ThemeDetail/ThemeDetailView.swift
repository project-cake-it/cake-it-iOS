//
//  ThemeDetailView.swift
//  cake-it
//
//  Created by seungbong on 2021/06/20.
//

import UIKit

protocol ThemeDetailViewDelegate: AnyObject {
  func themeDetailCellDidTap(type: FilterCommon.FilterTheme)
  func themeBackgroundViewDidTap()
}

final class ThemeDetailView: UIView {
  
  enum Metric {
    static let tableViewDefaultHeight: CGFloat = 400.0
    static let footerCellHeight: CGFloat = 22.0
    static let defaultTableCellHight: CGFloat = 38.0
    static let tableViewRadius: CGFloat = 16.0
  }
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var themeTableView: UITableView!
  var themeTableViewHeightConstraint: NSLayoutConstraint?

  weak var delegate: ThemeDetailViewDelegate?
  var selectedTheme: FilterCommon.FilterTheme = .birthday
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
    let view = Bundle.main.loadNibNamed(String(describing: ThemeDetailView.self),
                                        owner: self,
                                        options: nil)?.first as! UIView
    self.addSubview(view)
  }
  
  private func configureView() {
    registerCell()
    
    themeTableView.delegate = self
    themeTableView.dataSource = self
    themeTableView.separatorStyle = .none
    themeTableView.round(cornerRadius: Metric.tableViewRadius,
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

    themeTableView.constraints(topAnchor: self.topAnchor,
                                leadingAnchor: self.leadingAnchor,
                                trailingAnchor: self.trailingAnchor)
    themeTableViewHeightConstraint = themeTableView.heightAnchor.constraint(equalToConstant: Metric.tableViewDefaultHeight)
    themeTableViewHeightConstraint?.isActive = true
  }
  
  private func registerCell() {
    let identifier = String(describing: CakeDesignThemeCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    themeTableView.register(nib, forCellReuseIdentifier: identifier)
  }
  
  @objc private func backgroundViewDidTap() {
    delegate?.themeBackgroundViewDidTap()
    
    for subView in self.subviews {
      subView.removeFromSuperview()
    }
    self.removeFromSuperview()
  }
  
  func resetData() {
    tableViewHeight = 0.0
  }
}
