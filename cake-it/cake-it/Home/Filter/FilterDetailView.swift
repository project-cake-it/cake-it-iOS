//
//  FilterDetailView.swift
//  cake-it
//
//  Created by seungbong on 2021/04/06.
//

import Foundation
import UIKit

protocol FilterDetailViewDelegate {
  func filterDidSelected(key: FilterDetailView.FilterType, value: String)
}

class FilterDetailView: UIView {
  
  @IBOutlet weak var backgroundView: UIView!
  
  var delegate: FilterDetailViewDelegate?
  var filterType: FilterType = .reset
  var index: Int = 0 {
    didSet {
      if index < FilterType.allCases.count {
        filterType = FilterType.allCases[index]
      }
      configureView()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    let view = Bundle.main.loadNibNamed(String(describing: FilterDetailView.self),
                                        owner: self,
                                        options: nil)?.first as! UIView
    self.addSubview(view)
  }
  
  private func configureView() {
    var viewList: [UIView] = []
    switch filterType {
    case .reset:
      configureResetList()
    case .basic:
      viewList = configureBasicList()
    case .region:
      viewList = configureRegionList()
    case .size:
      viewList = configureSizeList()
    case .color:
      viewList = configureColorList()
    case .category:
      viewList = configureCategoryList()
    }

    let stackView = UIStackView(arrangedSubviews: viewList)
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    self.addSubview(stackView)

    let viewHight = CGFloat(viewList.first?.frame.height ?? 0) * CGFloat(viewList.count)
    stackView.constraints(topAnchor: self.topAnchor,
                          leadingAnchor: self.leadingAnchor,
                          trailingAnchor: self.trailingAnchor,
                          height: viewHight)
  }
  
  private func configureResetList() {
  }
  
  private func configureBasicList() -> [UIView] {
    var viewList: [TitleFilterCell] = []
    
    for i in 0..<FilterBasic.allCases.count {
      let baseCell = TitleFilterCell(frame: CGRect(x: 0, y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: 40))
      baseCell.delegate = self
      baseCell.filterIndex = i
      baseCell.label.text = FilterBasic.allCases[i].title
      viewList.append(baseCell)
    }
    
    return viewList
  }
  
  private func configureRegionList() -> [UIView] {
    var viewList: [TitleFilterCell] = []
    
    for i in 0..<FilterRegion.allCases.count {
      let regionCell = TitleFilterCell(frame: CGRect(x: 0, y: 0,
                                                     width: UIScreen.main.bounds.width,
                                                     height: 40))
      regionCell.delegate = self
      regionCell.filterIndex = i
      regionCell.label.text = FilterRegion.allCases[i].title
      viewList.append(regionCell)
    }
    
    return viewList
  }
  
  private func configureSizeList() -> [UIView] {
    var viewList: [UIView] = []
    
    for i in 0..<FilterSize.allCases.count {
      let descriptionCell = DescriptionFilterCell(frame: CGRect(x: 0, y: 0,
                                                                width: UIScreen.main.bounds.width,
                                                                height: 60))
      descriptionCell.delegate = self
      descriptionCell.filterIndex = i
      descriptionCell.titleLabel.text = FilterSize.allCases[i].title
      descriptionCell.descriptionLabel.text = FilterSize.allCases[i].description
      viewList.append(descriptionCell)
    }
    
    return viewList
  }
  
  private func configureColorList() -> [UIView] {
    var viewList: [ColorFilterCell] = []
    
    for i in 0..<FilterColor.allCases.count {
      let colorCell = ColorFilterCell(frame: CGRect(x: 0, y: 0,
                                                    width: UIScreen.main.bounds.width,
                                                    height: 40))
      colorCell.delegate = self
      colorCell.filterIndex = i
      colorCell.colorLabel.text = FilterColor.allCases[i].title
      colorCell.colorView.backgroundColor = FilterColor.allCases[i].color
      viewList.append(colorCell)
    }
    
    return viewList
  }
  
  private func configureCategoryList() -> [UIView] {
    var viewList: [TitleFilterCell] = []
    
    for i in 0..<FilterCategory.allCases.count {
      let baseCell = TitleFilterCell(frame: CGRect(x: 0, y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: 40))
      baseCell.delegate = self
      baseCell.filterIndex = i
      baseCell.label.text = FilterCategory.allCases[i].title
      viewList.append(baseCell)
    }
    
    return viewList
  }
  
  @IBAction func tapGesture(_ sender: Any) {
    self.removeFromSuperview()
  }
  
}

extension FilterDetailView: BaseFilterCellDelegate {
  
  func cellDidTap(index: Int) {
    
    var value: String = ""
    
    switch filterType {
    case .basic:
      value = FilterBasic.allCases[index].title
    case .region:
      value = FilterRegion.allCases[index].title
    case .size:
      value = FilterSize.allCases[index].title
    case .color:
      value = FilterColor.allCases[index].title
    case .category:
      value = FilterCategory.allCases[index].title
    case .reset:
      break
    }
    
    delegate?.filterDidSelected(key: filterType, value: value)
  }
  
}

// Filter Detail Enum
extension FilterDetailView {
  
  enum FilterType: String, CaseIterable {
    case reset    = "reset"   // 초기화
    case basic    = "basic"   // 기본순
    case region   = "region"  // 지역
    case size     = "size"    // 크기
    case color    = "color"   // 색깔
    case category = "category"// 카테고리
    
    var title: String {
      return self.rawValue
    }
  }
  
  enum FilterBasic: String, CaseIterable {
    case basic = "기본순"
    case zzim = "찜 순"
    case price_hight = "가격 높은 순"
    case price_low = "가격 낮은 순"
    
    var title: String {
      return self.rawValue
    }
  }
  
  enum FilterRegion: String, CaseIterable {
    case gangnam = "강남구"
    case gwangjin = "광진구"
    case gwanak = "관악구"
    case mapo = "마포구"
    case seodeamun = "서대문구"
    case songpa = "송파구"
    
    var title: String {
      return self.rawValue
    }
  }
  
  enum FilterSize: String, CaseIterable {
    case mini = "미니"
    case size_1 = "1호"
    case size_2 = "2호"
    case size_3 = "3호"
    case two_tier = "2단"
    
    var title: String {
      return self.rawValue
    }
    
    var description: String {
      switch self {
      case .mini: return "10-11cm, 1-2인용"
      case .size_1: return "15-16cm, 3-4인용"
      case .size_2: return "18cm, 5-6인용"
      case .size_3: return "21cm, 7-8인용"
      case .two_tier: return "파티용 특별제작"
      }
    }
  }
  
  enum FilterColor: String, CaseIterable {
    case white = "화이트"
    case pink = "핑크"
    case yellow = "옐로우"
    case red = "레드"
    case blue = "블루"
    case purple = "퍼플"
    case other = "기타"
    
    var title: String {
      return self.rawValue
    }
    
    var color: UIColor {
      switch self {
      case .white:  return Colors.design_white
      case .pink:   return Colors.design_pink
      case .yellow: return Colors.design_yellow
      case .red:    return Colors.design_red
      case .blue:   return Colors.design_blue
      case .purple: return Colors.design_purple
      case .other:  return Colors.design_other
      }
    }
  }
  
  enum FilterCategory: String, CaseIterable {
    case lettering = "문구"
    case image = "이미지"
    case character = "캐릭터"
    case individuality = "개성"
    
    var title: String {
      return self.rawValue
    }
  }
}
