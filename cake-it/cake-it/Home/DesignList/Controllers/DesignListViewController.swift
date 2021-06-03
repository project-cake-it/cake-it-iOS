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
  }
  
  @IBOutlet weak var navigationBarView: UIView!
  @IBOutlet weak var navigationBarTitleLabel: UILabel!
  @IBOutlet weak var navigationBarTitleTapGestureView: UIView!
  @IBOutlet weak var navigationBarTitleArrowIcon: UIImageView!
  @IBOutlet weak var designsCollectionView: UICollectionView!
  @IBOutlet weak var filterCategoryCollectionView: UICollectionView!
  
  
  private(set) var cakeDesigns: [CakeDesign] = []
//  private(set) var cakeDesignsResponse: [CakeDesign.Response] = []
  private(set) var cakeFilterList: [FilterCommon.FilterType] = [.reset, .basic, .region, .size, .color, .category]
  var filterDetailView: FilterDetailView?
  var selectedFilterDic: Dictionary<String, [String]> = [:]
  var hightlightedFilterType: FilterCommon.FilterType = .reset
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
//    fetchCakeDesigns()
    requestData()
  }
  
  // Testing
  private func requestData() {
    NetworkManager.shared.requestGet(api: .designs,
                                     type: [CakeDesign].self) { (response) in
      switch response {
      case .success(let result):
        self.cakeDesigns = result
        print(self.cakeDesigns)
        self.designsCollectionView.reloadData()
      case .failure(let error):
        print(error)
      }
    }
  }
  // Testing
  
  private func fetchCakeDesigns() {
//    let tempImageURL = "https://postfiles.pstatic.net/MjAyMTAzMjVfMjUw/MDAxNjE2Njg0MTc2OTc5.uKjj9xmaLrbGIbhnwiF7qhOroinNd60gbl8Jr6rMH18g.R7eRAZeHfGBv-wb8VZwo-r9IRqSLS-8Phocr7oiQ-g8g.PNG.cory_kim/Screen_Shot_2021-03-25_at_11.51.45_PM.png?type=w966"
//    for _ in 0..<15 {
//      cakeDesigns.append(CakeDesign(image: tempImageURL,
//                                    location: "강남구",
//                                    size: "1호 13cm",
//                                    name: "화중이맛 케이크",
//                                    price: 35000))
//    }
//    designsCollectionView.reloadData()
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func navigationTitleDidTap() {
    UIView.animate(withDuration: 0.2) {
      self.navigationBarTitleArrowIcon.transform = CGAffineTransform(rotationAngle: .pi)
    }
  }
}

extension DesignListViewController {
  private func configure() {
    configureFilterCategoryView()
    configureCollectionView()
    configureNavigationBarTapGesture()
  }
  
  // MARK:- configure filter title collectionView
  private func configureFilterCategoryView() {
    configureFilterCategoryCollectionView()
    registerFilterCategoryCollectionView()
  }
  
  private func configureFilterCategoryCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    filterCategoryCollectionView.collectionViewLayout = flowLayout
    filterCategoryCollectionView.delegate = self
    filterCategoryCollectionView.dataSource = self
    filterCategoryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
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

  // MARK:- configure navigation bar
  private func configureNavigationBarTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationTitleDidTap))
    navigationBarTitleTapGestureView.addGestureRecognizer(tapGesture)
  }
}
