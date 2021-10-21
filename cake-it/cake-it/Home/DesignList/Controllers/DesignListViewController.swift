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
    static let filterCollectionViewInterItemSpacing: CGFloat = 8.0
    static let selectedFilterOptionCollectionViewHeight: CGFloat = 46.0
    static let selectedFilterOptionCollectionViewSideContentInset: CGFloat = 16.0
  }

  enum NaviArrowDirection {
    case up
    case down
  }

  @IBOutlet weak var navigationBarView: UIView!
  @IBOutlet weak var navigationBarTitleLabel: UILabel!
  @IBOutlet weak var navigationBarTitleTapGestureView: UIView!
  @IBOutlet weak var navigationBarTitleArrowIcon: UIImageView!
  
  @IBOutlet var designEmptyView: UIView!
  @IBOutlet weak var designsCollectionView: UICollectionView!
  @IBOutlet weak var filterCategoryCollectionView: UICollectionView!
  @IBOutlet var selectedFilterOptionCollectionView: UICollectionView!
  @IBOutlet var selectedFilterOptionCollectionViewHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var filterDetailContainerView: UIView!
  @IBOutlet weak var navigationBarHeightConstraint: NSLayoutConstraint!
  
  private let filterLoadingBlockView = UIView()
  private let loadingBlockView = LoadingBlockView()
  
  var cakeDesigns: [CakeDesign] = []
  private(set) var cakeFilterList: [FilterCommon.FilterType] = [.reset, .order, .region, .size, .color, .category]
  var selectedThemeType: FilterCommon.FilterTheme = .birthday  {     // 선택된 디자인 테마
    didSet {
      selectedTheme = [FilterCommon.FilterTheme.key: selectedThemeType.value]
      navigationBarTitleLabel?.text = selectedThemeType.title
    }
  }
  fileprivate var selectedTheme: [String: String] = [:]     // 선택된 테마 리스트
  var selectedFilter: [String: [String]] = [:]  // 선택된 필터 리스트
  var selectedFilterOptions: [SelectedFilterOption] = []
  var searchKeyword: [String: String] = [:]     // 검색 키워드
  var highlightedFilterType: FilterCommon.FilterType = .reset // 현재 포커스된 필터
  var filterDetailVC: FilterDetailViewController?     // 필터 디테일 리스트
  var themeDetailView: ThemeDetailView?       // 테마 디테일 리스트
  var isFetchingDesigns = false {
    didSet {
      updateLoadingBlockView(isFetchingDesigns: isFetchingDesigns)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configure()
    
    if cakeDesigns.isEmpty {
      fetchCakeDesigns()
    }
  }

  func fetchCakeDesigns() {
    if let _ = self.parent as? SearchResultViewController {
      requestSearchingDesigns()
    } else {
      requestDesigns()
    }
  }
  
  private func updateLoadingBlockView(isFetchingDesigns: Bool) {
    if isFetchingDesigns {
      loadingBlockView.isHidden = false
      filterLoadingBlockView.isHidden = false
    } else {
      loadingBlockView.isHidden = true
      filterLoadingBlockView.isHidden = true
    }
  }
  
  private func requestDesigns() {
    self.isFetchingDesigns = true
    let parameter = mergedFilterQueryString(with: selectedTheme)
    NetworkManager.shared.requestGet(api: .designs,
                                     type: [CakeDesign].self,
                                     param: parameter) { (response) in
      switch response {
      case .success(let designs):
        self.cakeDesigns = designs
        self.designsCollectionView.reloadData()
        self.checkEmptyView()
        self.isFetchingDesigns = false
        
      case .failure(let error):
        self.isFetchingDesigns = false
        print(error.localizedDescription)
      }
    }
  }
  
  private func requestSearchingDesigns() {
    self.isFetchingDesigns = true
    let parameter = mergedFilterQueryString(with: searchKeyword)
    NetworkManager.shared.requestGet(api: .search,
                                     type: SearchResult.self,
                                     param: parameter) { (response) in
      switch response {
      case .success(let searchResult):
        self.cakeDesigns = searchResult.designs
        self.designsCollectionView.reloadData()
        self.checkEmptyView()
        self.isFetchingDesigns = false
      case .failure(let error):
        print(error.localizedDescription)
        self.isFetchingDesigns = false
      }
    }
  }
  
  private func checkEmptyView() {
    if self.cakeDesigns.isEmpty {
      self.designEmptyView.isHidden = false
    } else {
      self.designEmptyView.isHidden = true
    }
  }

  private func mergedFilterQueryString(with otherFilter: [String: String]) -> String {
    var mergedFilterDic: [String: [String]] = selectedFilter
    if let key = otherFilter.keys.first,
       let value = otherFilter.values.first {
      mergedFilterDic[key] = [value]
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

// MARK: - Selected Filter Option

extension DesignListViewController {
  func updateSelectedFilterOptionCollectionViewLayout() {
    guard selectedFilterOptions.count > 0 else {
      selectedFilterOptionCollectionViewHeightConstraint.constant = 0
      return
    }
    selectedFilterOptionCollectionViewHeightConstraint.constant = Metric.selectedFilterOptionCollectionViewHeight
  }
}

extension DesignListViewController: SelectedFilterOptionCellDelegate {
  func selectedFilterOptionCell(closeButtonDidTap fromCell: SelectedFilterOptionCell) {
    guard isFetchingDesigns == false else { return }
    guard let indexPath = selectedFilterOptionCollectionView.indexPath(for: fromCell) else { return }
    let options = selectedFilterOptions
    let option = options[indexPath.row]
    let key = option.key
    var values = selectedFilter[key]!
    var selectedValueIndex = 0
    values.enumerated().forEach { (index, value) in
      if values.contains(value) {
        selectedValueIndex = index
      }
    }
    values.remove(at: selectedValueIndex)
    selectedFilter[key] = values // Dictionary는 순회하여 key에서 해당 value 값 제거
    selectedFilterOptions.remove(at: indexPath.row)
    
    updateSelectedFilterOptionCollectionViewLayout()
    designsCollectionView.reloadData()
    selectedFilterOptionCollectionView.reloadData()
    filterCategoryCollectionView.reloadData()
    fetchCakeDesigns()
  }
}

extension DesignListViewController {
  private func configure() {
    configureNavigationBarView()
    configureFilterView()
    configureCollectionView()
    configureSelectedFilterOptionCollectionView()
    configureLoadingBlockViews()
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
                                                             left: FilterCommon.Metric.filterCollectionViewSideContentInset,
                                                             bottom: 0,
                                                             right: FilterCommon.Metric.filterCollectionViewSideContentInset)
  }
  
  private func configureFilterDetailView() {
    let id = String(describing: FilterDetailViewController.self)
    filterDetailVC = FilterDetailViewController(nibName: id, bundle: nil)
    guard let detailVC = filterDetailVC else { return }
    detailVC.delegate = self
    filterDetailContainerView.addSubview(detailVC.view)
    hideFilterDetailContainerView()
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
  
  private func configureSelectedFilterOptionCollectionView() {
    selectedFilterOptionCollectionViewHeightConstraint.constant = 0
    selectedFilterOptionCollectionView.delegate = self
    selectedFilterOptionCollectionView.dataSource = self
    let identifier = String(describing: SelectedFilterOptionCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    selectedFilterOptionCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
    selectedFilterOptionCollectionView.bounces = true
    let contentInset = UIEdgeInsets(top: 0,
                                    left: Metric.selectedFilterOptionCollectionViewSideContentInset,
                                    bottom: 0,
                                    right: Metric.selectedFilterOptionCollectionViewSideContentInset)
    selectedFilterOptionCollectionView.contentInset = contentInset
  }
  
  private func configureLoadingBlockViews() {
    view.addSubview(loadingBlockView)
    loadingBlockView.constraints(topAnchor: designsCollectionView.topAnchor,
                                 leadingAnchor: designsCollectionView.leadingAnchor,
                                 bottomAnchor: designsCollectionView.bottomAnchor,
                                 trailingAnchor: designsCollectionView.trailingAnchor)
    view.bringSubviewToFront(filterDetailContainerView)
    filterLoadingBlockView.backgroundColor = .white
    filterLoadingBlockView.alpha = 0.3
    view.addSubview(filterLoadingBlockView)
    filterLoadingBlockView.constraints(topAnchor: filterCategoryCollectionView.topAnchor,
                                       leadingAnchor: view.leadingAnchor,
                                       bottomAnchor: designsCollectionView.topAnchor,
                                       trailingAnchor: view.trailingAnchor)
  }
}
