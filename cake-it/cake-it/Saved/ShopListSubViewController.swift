//
//  SavedItemStoreListSubViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/03.
//

import Foundation
import XLPagerTabStrip

final class ShopListSubViewController: BaseViewController, IndicatorInfoProvider {
  
  enum Metric {
    static let cakeShopCellInterItemVerticalSpace: CGFloat = 4.0
    static let cakeShopCellHeight: CGFloat = 124.0
  }
  
  @IBOutlet weak var cakeShopCollectionView: UICollectionView!
  
  private(set) var cakeShops: [CakeShop] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCakeShopCollecionView()
    fetchCakeShops()
  }
  
  private func fetchCakeShops() {
    //TODO: 서버연동
    for _ in 0..<20 {
//      cakeShops.append(CakeShop(image: "https://postfiles.pstatic.net/MjAyMTAzMjVfMjUw/MDAxNjE2Njg0MTc2OTc5.uKjj9xmaLrbGIbhnwiF7qhOroinNd60gbl8Jr6rMH18g.R7eRAZeHfGBv-wb8VZwo-r9IRqSLS-8Phocr7oiQ-g8g.PNG.cory_kim/Screen_Shot_2021-03-25_at_11.51.45_PM.png?type=w966", name: "케이크 가게 이름", address: "허리도 가늘군", tags: ["파티", "개미"], saved: true, miniSizeCakePrice: 18000, levelOneSizeCakePrice: 32000))
    }
    cakeShopCollectionView.reloadData()
  }
  
  private func configureCakeShopCollecionView() {
    let identifier = String(describing: CakeShopCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    cakeShopCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
    
    cakeShopCollectionView.delegate = self
    cakeShopCollectionView.dataSource = self
  }
  
  //MARK: -XLPager
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: Constants.STORE_LIST_SUB_VIEW_TITLE)
  }
}
