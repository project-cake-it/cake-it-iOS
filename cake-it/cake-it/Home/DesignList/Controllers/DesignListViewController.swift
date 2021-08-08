//
//  DesignListViewController.swift
//  cake-it
//
//  Created by Cory on 2021/03/16.
//

import UIKit

final class DesignListViewController: BaseViewController {

  enum Metric {
    static let cakeDesignsCollectionViewSidePadding: CGFloat = 0
    static let cakeDesignCellInterItemHorizontalSpace: CGFloat = 1.0
    static let cakeDesignCellInterItemVerticalSpace: CGFloat = 4.0
  }

  enum NaviArrowDirection {
    case up
    case down
  }

  @IBOutlet weak var navigationBarView: UIView!
  @IBOutlet weak var navigationBarTitleLabel: UILabel!
  @IBOutlet weak var navigationBarTitleTapGestureView: UIView!
  @IBOutlet weak var navigationBarTitleArrowIcon: UIImageView!
  
  @IBOutlet weak var designsCollectionView: UICollectionView!
  @IBOutlet weak var filterCategoryCollectionView: UICollectionView!

  @IBOutlet weak var filterDetailContainerView: UIView!
  @IBOutlet weak var navigationBarHeightConstraint: NSLayoutConstraint!
  
  var cakeDesigns: [CakeDesign] = []
  private(set) var cakeFilterList: [FilterCommon.FilterType] = [.reset, .order, .region, .size, .color, .category]
  var selectedThemeType: FilterCommon.FilterTheme = .none  {     // 선택된 디자인 테마
    didSet {
      selectedTheme = [FilterCommon.FilterTheme.key: selectedThemeType.value]
      navigationBarTitleLabel?.text = selectedThemeType.title
    }
  }
  fileprivate var selectedTheme: [String: String] = [:]     // 선택된 테마 리스트
  var selectedFilter: [String: [String]] = [:]  // 선택된 필터 리스트
  var highlightedFilterType: FilterCommon.FilterType = .reset // 현재 포커스된 필터
  var filterDetailVC: FilterDetailViewController?     // 필터 디테일 리스트
  var themeDetailView: ThemeDetailView?       // 테마 디테일 리스트

  override func viewDidLoad() {
    super.viewDidLoad()

    configure()
    
    if cakeDesigns.isEmpty {
      fetchCakeDesigns()
    }
  }

  func fetchCakeDesigns() {
    let parameter = mergedQueryStringFromThemeAndFilter()
    NetworkManager.shared.requestGet(api: .designs,
                                     type: [CakeDesign].self,
                                     param: parameter) { (response) in
      switch response {
      case .success(let designs):
        self.cakeDesigns = designs
        self.designsCollectionView.reloadData()

      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

  private func mergedQueryStringFromThemeAndFilter() -> String {
    var mergedFilterDic: [String: [String]] = selectedFilter
    if let themeKey = selectedTheme.keys.first,
       let themeValue = selectedTheme.values.first {
      mergedFilterDic[themeKey] = [themeValue]
    }
    let parameter = mergedFilterDic.queryString()
    return parameter
  }

  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }

  @objc private func navigationTitleDidTap() {
    resetCategoryFilter()
    if self.isShowThemeDetailView() {
      self.hideThemeDetailView()
    } else {
      self.showThemeDetailView()
    }
  }
}

extension DesignListViewController {
  private func configure() {
    configureNavigationBarView()
    configureFilterView()
    configureCollectionView()
  }

  // MARK:- configure navigation bar
  private func configureNavigationBarView() {
    navigationBarTitleLabel.text = selectedThemeType.title
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationTitleDidTap))
    navigationBarTitleTapGestureView.addGestureRecognizer(tapGesture)
  }

  // MARK:- configure filter title collectionView
  private func configureFilterView() {
    configureFilterCategoryView()
    configureFilterDetailView()
  }

  private func configureFilterCategoryView() {
    configureFilterCategoryCollectionView()
    registerFilterCategoryCollectionView()
  }

  private func configureFilterCategoryCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    if #available(iOS 14, *) {
      flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    filterCategoryCollectionView.collectionViewLayout = flowLayout
    filterCategoryCollectionView.delegate = self
    filterCategoryCollectionView.dataSource = self
    filterCategoryCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                             left: FilterCommon.Metric.categoryCellLeftMargin,
                                                             bottom: 0,
                                                             right: 0)
  }
  
  private func configureFilterDetailView() {
    let id = String(describing: FilterDetailViewController.self)
    filterDetailVC = FilterDetailViewController(nibName: id, bundle: nil)
    guard let detailVC = filterDetailVC else { return }
    detailVC.delegate = self
    filterDetailContainerView.addSubview(detailVC.view)
    hideFilterDetailView()
    addChild(detailVC)
  }

  private func registerFilterCategoryCollectionView() {
    let identifier = String(describing: FilterCategoryCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    filterCategoryCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
  }

  // MARK:- configure cake design collectionView
  private func configureCollectionView() {
    configureCollectionViewProtocols()
    registerCollectionViewCell()
  }

  private func registerCollectionViewCell() {
    let identifier = String(describing: CakeDesignCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    designsCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
  }

  private func configureCollectionViewProtocols() {
    designsCollectionView.dataSource = self
    designsCollectionView.delegate = self
  }
  
  func hideNavigationView() {
    navigationBarView?.isHidden = true
    navigationBarHeightConstraint?.constant = 0.0
  }
}
