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
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private(set) var cakeShops: [CakeShop] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    fetchCakeShops()
  }
  
  private func fetchCakeShops() {
    for _ in 0..<20 {
      cakeShops.append(CakeShop(image: "https://postfiles.pstatic.net/MjAyMTAzMjVfMjUw/MDAxNjE2Njg0MTc2OTc5.uKjj9xmaLrbGIbhnwiF7qhOroinNd60gbl8Jr6rMH18g.R7eRAZeHfGBv-wb8VZwo-r9IRqSLS-8Phocr7oiQ-g8g.PNG.cory_kim/Screen_Shot_2021-03-25_at_11.51.45_PM.png?type=w966", name: "케이크 가게 이름", address: "허리도 가늘군", tags: ["파티", "개미"], saved: true))
    }
    collectionView.reloadData()
  }
}

extension ShopsMainViewController {
  private func configure() {
    configureCollectionView()
  }
  
  private func configureCollectionView() {
    registerCollectionViewCell()
    configureCollectionViewProtocols()
  }
  
  private func registerCollectionViewCell() {
    let identifier = String(describing: CakeShopCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: identifier)
  }
  
  private func configureCollectionViewProtocols() {
    collectionView.dataSource = self
    collectionView.delegate = self
  }
}
