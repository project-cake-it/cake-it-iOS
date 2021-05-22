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
  @IBOutlet weak var filterViewArea: UIView!
  @IBOutlet weak var designsCollectionView: UICollectionView!
  
  @IBOutlet weak var filterTitleCollectionView: UICollectionView!
  private var filterDetailView = FilterDetailView()
  private(set) var cakeDesigns: [CakeDesign] = []
  
  var selectedFilterDic: Dictionary<String, [String]> = [:]
  
  // testing...
  let cakeFilterList: [FilterCommon.FilterType] = [.reset, .basic, .region, .size, .color, .category]
  // testing...

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    fetchCakeDesigns()
  }
  
  private func fetchCakeDesigns() {
    let tempImageURL = "https://postfiles.pstatic.net/MjAyMTAzMjVfMjUw/MDAxNjE2Njg0MTc2OTc5.uKjj9xmaLrbGIbhnwiF7qhOroinNd60gbl8Jr6rMH18g.R7eRAZeHfGBv-wb8VZwo-r9IRqSLS-8Phocr7oiQ-g8g.PNG.cory_kim/Screen_Shot_2021-03-25_at_11.51.45_PM.png?type=w966"
    for _ in 0..<15 {
      cakeDesigns.append(CakeDesign(image: tempImageURL,
                                    location: "강남구",
                                    size: "1호 13cm",
                                    name: "화중이맛 케이크",
                                    price: 35000))
    }
    designsCollectionView.reloadData()
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
    configureFilterTitleView()
    configureCollectionView()
    configureNavigationBarTapGesture()
  }
  
  private func configureFilterTitleView() {
//    let filterView = FilterTitleView(frame: CGRect(x: 0,
//                                                   y: 0,
//                                                   width: filterViewArea.frame.width,
//                                                   height: filterViewArea.frame.height))
//    filterView.delegate = self
//    filterView.filterList = cakeFilterList
//    filterViewArea.addSubview(filterView)
    
    // new code
    let identifier = String(describing: FilterTitleCell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    filterTitleCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
    filterTitleCollectionView.delegate = self
    filterTitleCollectionView.dataSource = self
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    filterTitleCollectionView.collectionViewLayout = flowLayout
  }
  
  private func configureNavigationBarTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationTitleDidTap))
    navigationBarTitleTapGestureView.addGestureRecognizer(tapGesture)
  }
  
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
}

extension DesignListViewController: FilterTitleViewDelegate, FilterDetailViewDelegate {
  
  // filter 타이틀 클릭
  func filterTitleButtonDidTap(type: FilterCommon.FilterType) {
    removeFiterDetailView()
    
    if type == .reset {
      selectedFilterDic.removeAll()
      return
    }
    
    filterDetailView = FilterDetailView()
    filterDetailView.filterType = type
    filterDetailView.delegate = self
    self.view.addSubview(filterDetailView)
    filterDetailView.constraints(topAnchor: filterViewArea.bottomAnchor,
                                 leadingAnchor: view.leadingAnchor,
                                 bottomAnchor: view.bottomAnchor,
                                 trailingAnchor: view.trailingAnchor)
  }
  
  // filter detail view 클릭
  func filterDetailViewDidTap(key: FilterCommon.FilterType, value: String) {
    var savedValues = selectedFilterDic[key.title] ?? []
    if selectedFilterDic.keys.contains(key.title) == true, savedValues.contains(value) {
      let index = savedValues.firstIndex(of: value)!
      savedValues.remove(at: index)  // 이미 선택된 경우 선택 취소
    } else {
      savedValues.append(value) // 없는 경우 추가
    }
    selectedFilterDic[key.title] = savedValues
    print(selectedFilterDic) // dictionary 내용 확인을 위해 주석 (개발 후 제거 필요)
  }
  
  private func removeFiterDetailView() {
    for view in filterDetailView.subviews {
      view.removeFromSuperview()
    }
    filterDetailView.removeFromSuperview()
  }
  
}
