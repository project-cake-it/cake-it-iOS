//
//  SavedItemCakeListSubViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/03.
//

import Foundation
import XLPagerTabStrip

final class CakeListSubViewController: UIViewController, IndicatorInfoProvider {
  
  @IBOutlet weak var cakeImageCollectionView: UICollectionView!
  
  private(set) var cakeImages: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchCakeImages()
    configureCakeImageCollectionView()
  }
  
  private func fetchCakeImages() {
    //TODO: 서버통신
    let tempImageURL = "https://postfiles.pstatic.net/MjAyMTAzMjVfMjUw/MDAxNjE2Njg0MTc2OTc5.uKjj9xmaLrbGIbhnwiF7qhOroinNd60gbl8Jr6rMH18g.R7eRAZeHfGBv-wb8VZwo-r9IRqSLS-8Phocr7oiQ-g8g.PNG.cory_kim/Screen_Shot_2021-03-25_at_11.51.45_PM.png?type=w966"
    for _ in 0..<15 {
      cakeImages.append(tempImageURL)
    }
    
    cakeImageCollectionView.reloadData()
  }
  
  private func configureCakeImageCollectionView() {
    cakeImageCollectionView.delegate = self
    cakeImageCollectionView.dataSource = self
    
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
