//
//  FilterDetailView.swift
//  cake-it
//
//  Created by seungbong on 2021/04/06.
//

import Foundation
import UIKit

class FilterDetailView: UIView {
  
  @IBOutlet weak var backgroundView: UIView!
  var index: Int = 0 {
    didSet {
      switch index {  // 여기 일일ㅇ ㅣ수정해주는거 바꿔야됨!!!!! 외냐면 수정할때 여기랑 extension enum 같ㅇ ㅣ바꿔야하기 때문!!
      case 0: filterIndex = .reset
      case 1: filterIndex = .basic
      case 2: filterIndex = .region
      case 3: filterIndex = .size
      case 4: filterIndex = .color
      case 5: filterIndex = .category
      default: filterIndex = .reset
      }
      configureView()
    }
  }
  var filterIndex: FilterType = .reset
  
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
    switch filterIndex {
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
    stackView.spacing = 35
    stackView.distribution = .fillProportionally
    stackView.alignment = .leading
    self.addSubview(stackView)

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    stackView.sizeToFit()
  }
  
  private func configureResetList() {
  }
  
  private func configureBasicList() -> [UIView] {
    var viewList: [BasicFilterCell] = []
    for type in FilterBasic.allCases {
      let basicCell = BasicFilterCell()
      basicCell.label.text = type.rawValue
      viewList.append(basicCell)
    }
    
    return viewList
  }
  
  private func configureRegionList() -> [UIView] {
    var viewList: [BasicFilterCell] = []
    for type in FilterRegion.allCases {
      let basicCell = BasicFilterCell()
      basicCell.label.text = type.rawValue
      viewList.append(basicCell)
    }
    
    return viewList
  }
  
  private func configureSizeList() -> [UIView] {
    var viewList: [DescriptionFilterCell] = []
    for type in FilterSize.allCases {
      let descriptionCell = DescriptionFilterCell()
      descriptionCell.titleLabel.text = type.title
      descriptionCell.descriptionLabel.text = type.description
      descriptionCell.heightAnchor.constraint(equalToConstant: 30).isActive = true
      viewList.append(descriptionCell)
    }
    
    return viewList
  }
  
  private func configureColorList() -> [UIView] {
    var viewList: [ColorFilterCell] = []
    for type in FilterColor.allCases {
      let colorCell = ColorFilterCell()
      colorCell.colorLabel.text = type.rawValue
      colorCell.colorView.backgroundColor = type.color
      viewList.append(colorCell)
    }
    
    return viewList
  }
  
  private func configureCategoryList() -> [UIView] {
    var viewList: [BasicFilterCell] = []
    for type in FilterCategory.allCases {
      let basicCell = BasicFilterCell()
      basicCell.label.text = type.rawValue
      viewList.append(basicCell)
    }
    
    return viewList
  }
}


// Filter Detail Enum
extension FilterDetailView {
  
  enum FilterType {
    case reset    // 초기화
    case basic    // 기본순
    case region   // 지역
    case size     // 크기
    case color    // 색깔
    case category // 카테고리
  }
  
  enum FilterBasic: String, CaseIterable {
    case basic = "기본순"
    case zzim = "찜 순"
    case price_hight = "가격 높은 순"
    case price_low = "가격 낮은 순"
  }
  
  enum FilterRegion: String, CaseIterable {
    case gangnam = "강남구"
    case gwangjin = "광진구"
    case gwanak = "관악구"
    case mapo = "마포구"
    case seodeamun = "서대문구"
    case songpa = "송파구"
    
    var name: String {
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
  }
}
