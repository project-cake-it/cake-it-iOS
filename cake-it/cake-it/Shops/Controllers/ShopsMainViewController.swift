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
  }
  
  @IBOutlet weak var titleView: UIView!
  @IBOutlet weak var titleViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var filterCollectionView: UICollectionView!
  @IBOutlet weak var filterDetailContainerView: UIView!
  @IBOutlet weak var shopCollectionView: UICollectionView!
  
  var cakeShops: [CakeShop] = []
  private(set) var shopFilterList: [FilterCommon.FilterType] = [.reset, .order, .region, .pickupDate]
  var filterDetailVC: FilterDetailViewController?
  var selectedFilter: Dictionary<String, [String]> = [:]
  var searchKeyword: [String: String] = [:]
  var highlightedFilterType: FilterCommon.FilterType = .reset

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    
    if cakeShops.isEmpty {
      fetchCakeShops()
    }
  }
  
  func fetchCakeShops() {
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
        
      case .failure(_):
        // TODO: 에러 핸들링
        break
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

      case .failure(let error):
        print(error.localizedDescription)
      }
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

extension ShopsMainViewController {
  private func configure() {
    configureFilterView()
    configureCollectionView()
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
    hideFilterDetailView()
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
                                                     left: FilterCommon.Metric.categoryCellLeftMargin,
                                                     bottom: 0,
                                                     right: 0)
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
}
