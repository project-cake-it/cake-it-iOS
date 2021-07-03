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
  
  private(set) var savedCakeShops: [CakeShop] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCakeShopCollecionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchCakeShops()
  }
  
  private func fetchCakeShops() {
    NetworkManager.shared.requestGet(api: .savedShops,
                                     type: [CakeShop].self) { (response) in
      switch response {
      case .success(let result):
        self.savedCakeShops = result
        self.cakeShopCollectionView.reloadData()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
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
