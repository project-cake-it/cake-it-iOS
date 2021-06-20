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
  
  @IBOutlet weak var filterCollectionView: UICollectionView!
  @IBOutlet weak var storeCollectionView: UICollectionView!
  
  private(set) var cakeShops: [CakeShop] = []
  private(set) var storeFilterList: [FilterCommon.FilterType] = [.reset, .order, .region, .pickupDate]
  var filterDetailView: FilterDetailView?
  var selectedFilter: Dictionary<String, [String]> = [:]
  var hightlightedFilterType: FilterCommon.FilterType = .reset

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    fetchCakeShops()
  }
  
  private func fetchCakeShops() {
    for _ in 0..<20 {
      cakeShops.append(CakeShop(image: "https://postfiles.pstatic.net/MjAyMTAzMjVfMjUw/MDAxNjE2Njg0MTc2OTc5.uKjj9xmaLrbGIbhnwiF7qhOroinNd60gbl8Jr6rMH18g.R7eRAZeHfGBv-wb8VZwo-r9IRqSLS-8Phocr7oiQ-g8g.PNG.cory_kim/Screen_Shot_2021-03-25_at_11.51.45_PM.png?type=w966", name: "케이크 가게 이름", address: "허리도 가늘군", tags: ["파티", "개미"], saved: true, miniSizeCakePrice: 18000, levelOneSizeCakePrice: 32000))
    }
    storeCollectionView.reloadData()
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
    storeCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
  }
  
  private func configureCollectionViewProtocols() {
    storeCollectionView.dataSource = self
    storeCollectionView.delegate = self
  }
}
