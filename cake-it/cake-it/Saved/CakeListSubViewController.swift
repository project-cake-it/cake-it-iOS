//
//  SavedItemCakeListSubViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/03.
//

import Foundation
import XLPagerTabStrip

final class CakeListSubViewController: BaseViewController, IndicatorInfoProvider {
  
  @IBOutlet weak var cakeImageCollectionView: UICollectionView!
  @IBOutlet var savedDesignEmptyView: UIView!
  
  var savedCakeDesigns: [CakeDesign]?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCakeImageCollectionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchCakeImages()
  }
  
  private func fetchCakeImages() {
    NetworkManager.shared.requestGet(api: .savedDesigns,
                                     type: [CakeDesign].self) { (response) in
      switch response {
      case .success(let result):
        self.savedCakeDesigns = result
        self.cakeImageCollectionView.reloadData()
        self.checkEmptyView()
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func checkEmptyView() {
    guard let savedCakeDesigns = self.savedCakeDesigns else { return }
    if savedCakeDesigns.isEmpty  {
      savedDesignEmptyView.isHidden = false
    } else {
      savedDesignEmptyView.isHidden = true
    }
  }
  
  private func configureCakeImageCollectionView() {
    cakeImageCollectionView.dataSource = self
    cakeImageCollectionView.delegate = self
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    cakeImageCollectionView.collectionViewLayout = layout
  }
  
  //MARK: - XLPager
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: Constants.CAKE_LIST_SUB_VIEW_TITLE)
  }
}
