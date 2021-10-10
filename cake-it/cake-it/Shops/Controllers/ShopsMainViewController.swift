//
//  ShopListMainViewController.swift
//  cake-it
//
//  Created by Cory on 2021/02/16.
//

import UIKit

final class ShopsMainViewController: BaseViewController {
  
  enum Metric {
    static let cakeShopCellInterItemVerticalSpace: CGFloat = 4.0
    static let cakeShopCellHeight: CGFloat = 124.0
    static let filterCollectionViewInterItemSpacing: CGFloat = 8.0
    static let selectedFilterOptionCollectionViewHeight: CGFloat = 46.0
    static let selectedFilterOptionCollectionViewSideContentInset: CGFloat = 16.0
  }
  
  @IBOutlet weak var titleView: UIView!
  @IBOutlet weak var titleViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var filterCollectionView: UICollectionView!
  @IBOutlet var selectedFilterOptionCollectionView: UICollectionView!
  @IBOutlet var selectedFilterOptionCollectionViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet var shopEmptyView: UIView!
  @IBOutlet weak var filterDetailContainerView: UIView!
  @IBOutlet weak var shopCollectionView: UICollectionView!
  
  var cakeShops: [CakeShop] = []
  private(set) var shopFilterList: [FilterCommon.FilterType] = [.reset, .order, .region, .pickupDate]
  var filterDetailVC: FilterDetailViewController?
  var selectedFilter: Dictionary<String, [String]> = [:]
  var selectedFilterOptions: [SelectedFilterOption] = []
  var searchKeyword: [String: String] = [:]
  var highlightedFilterType: FilterCommon.FilterType = .reset
  var isFetchingCakes = false

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    
    if cakeShops.isEmpty {
      fetchCakeShops()
    }
  }
  
  func fetchCakeShops() {
    isFetchingCakes = true
    if let _ = self.parent as? SearchResultViewController {
      requestSearchingShops()
    } else {
      requestShops()
    }
  }
  
  private func requestShops() {
    NetworkManager.shared.requestGet(api: .shops,
                                     type: [CakeShop].self,
                                     param: selectedFilter.queryString()) { (response) in
      switch response {
      case .success(let cakeShops):
        self.cakeShops = cakeShops
        self.shopCollectionView.reloadData()
        self.checkEmptyView()
        self.isFetchingCakes = false
      case .failure(_):
        // TODO: 에러 핸들링
        self.isFetchingCakes = false
      }
    }
  }
  
  private func requestSearchingShops() {
    let parameter = mergedFilterQueryString(with: searchKeyword)
    NetworkManager.shared.requestGet(api: .search,
                                     type: SearchResult.self,
                                     param: parameter) { (response) in
      switch response {
      case .success(let searchResult):
        self.cakeShops = searchResult.shops
        self.shopCollectionView.reloadData()
        self.checkEmptyView()
        self.isFetchingCakes = false
      case .failure(let error):
        print(error.localizedDescription)
        self.isFetchingCakes = false
      }
    }
  }

  private func checkEmptyView() {
    if self.cakeShops.isEmpty {
      self.shopEmptyView.isHidden = false
    } else {
      self.shopEmptyView.isHidden = true
    }
  }

  private func mergedFilterQueryString(with dic: [String: String]) -> String {
    var mergedFilterDic: [String: [String]] = selectedFilter
    if let key = dic.keys.first,
       let value = dic.values.first {
      mergedFilterDic[key] = [value]
    }
    let parameter = mergedFilterDic.queryString()
    return parameter
  }
}

// MARK: - Selected Filter Option

extension ShopsMainViewController {
  func updateSelectedFilterOptionCollectionViewLayout() {
    guard selectedFilterOptions.count > 0 else {
      selectedFilterOptionCollectionViewHeightConstraint.constant = 0
      return
    }
    selectedFilterOptionCollectionViewHeightConstraint.constant = Metric.selectedFilterOptionCollectionViewHeight
  }
}

extension ShopsMainViewController: SelectedFilterOptionCellDelegate {
  func selectedFilterOptionCell(closeButtonDidTap fromCell: SelectedFilterOptionCell) {
    guard isFetchingCakes == false else { return }
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
    filterCollectionView.reloadData()
    selectedFilterOptionCollectionView.reloadData()
    if key == "pickup" {
      filterDetailVC?.selectedPickUpDate = nil
    }
    fetchCakeShops()
  }
}

// MARK: - Configuration

extension ShopsMainViewController {
  private func configure() {
    configureFilterView()
    configureCollectionView()
    configureSelectedFilterOptionCollectionView()
  }
  
  private func configureFilterView() {
    configureFilterCategoryView()
    configureFilterDetailView()
  }
  
  private func configureFilterCategoryView() {
    configureFilterCategoryCollectionView()
    registerFilterCategoryCollectionView()
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

  private func configureFilterCategoryCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    filterCollectionView.collectionViewLayout = flowLayout
    filterCollectionView.delegate = self
    filterCollectionView.dataSource = self
    filterCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                     left: FilterCommon.Metric.filterCollectionViewSideContentInset,
                                                     bottom: 0,
                                                     right: FilterCommon.Metric.filterCollectionViewSideContentInset)
  }

  private func registerFilterCategoryCollectionView() {
    let identifier = String(describing: FilterCategoryCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    filterCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
  }
  
  private func configureCollectionView() {
    registerCollectionViewCell()
    configureCollectionViewProtocols()
  }
  
  private func registerCollectionViewCell() {
    let identifier = String(describing: CakeShopCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    shopCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
  }
  
  private func configureCollectionViewProtocols() {
    shopCollectionView.dataSource = self
    shopCollectionView.delegate = self
  }
  
  func hideTitleView() {
    titleView.isHidden = true
    titleViewHeightConstraint.constant = 0.0
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
}
