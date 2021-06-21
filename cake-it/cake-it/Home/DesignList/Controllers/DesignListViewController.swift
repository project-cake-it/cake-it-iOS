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
  
  
  var cakeDesigns: [CakeDesign] = []
  private(set) var cakeFilterList: [FilterCommon.FilterType] = [.reset, .order, .region, .size, .color, .category]
  var filterDetailView: FilterDetailView?    // 필터 디테일 리스트
  var themeDetailView: ThemeDetailView?     // 테마 디테일 리스트
  var selectedThemeType: FilterCommon.FilterTheme = .none  {     // 선택된 디자인 테마
    didSet {
      navigationBarTitleLabel.text = selectedThemeType.title
    }
  }
  var selectedFilter: Dictionary<String, [String]> = [:]    // 선택된 필터 리스트
  var hightlightedFilterType: FilterCommon.FilterType = .reset // 현재 포커스된 필터
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    fetchCakeDesigns()
  }
  
  func fetchCakeDesigns(parameter: String = "") {
    NetworkManager.shared.requestGet(api: .designs,
                                     type: [CakeDesign].self,
                                     param: parameter) { (respons) in
      switch respons {
      case .success(let designs):
        self.cakeDesigns = designs
        self.designsCollectionView.reloadData()
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  @IBAction func themeButtonDidTap(_ sender: Any) {
    if isShowThemeDetailView() {
      hideThemeList()
    } else {
      showThemeList()
    }
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
    configureNavigationBarView()
  }
  
  // MARK:- configure navigation bar
  private func configureNavigationBarView() {
    navigationBarTitleLabel.text = selectedThemeType.title
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationTitleDidTap))
    navigationBarTitleTapGestureView.addGestureRecognizer(tapGesture)
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
    filterCategoryCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                             left: FilterCommon.Metric.categoryCellLeftMargin,
                                                             bottom: 0,
                                                             right: 0)
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
}
