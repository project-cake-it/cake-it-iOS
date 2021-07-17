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
  @IBOutlet weak var shopCollectionView: UICollectionView!
  
  private(set) var cakeShops: [CakeShop] = []
  private(set) var shopFilterList: [FilterCommon.FilterType] = [.reset, .order, .region, .pickupDate]
  var filterDetailView: FilterDetailView?
  var selectedFilter: Dictionary<String, [String]> = [:]
  var hightlightedFilterType: FilterCommon.FilterType = .reset

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    fetchCakeShops()
  }
  
  private func fetchCakeShops() {
    NetworkManager.shared.requestGet(api: .shops,
                                     type: [CakeShop].self,
                                     param: selectedFilter.queryString()
    ) { result in
      switch result {
      case .success(let cakeShops):
        self.cakeShops = cakeShops
        self.shopCollectionView.reloadData()
      case .failure(_):
        // TODO: 에러 핸들링
        break
      }
    }
  }
}

extension ShopsMainViewController {
  private func configure() {
    configureFilterCategoryView()
    configureCollectionView()
  }
  
  private func configureFilterCategoryView() {
    configureFilterCategoryCollectionView()
    registerFilterCategoryCollectionView()
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
