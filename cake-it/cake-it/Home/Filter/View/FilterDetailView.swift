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
    var detailList: [String] = []
    switch filterIndex {
    case .reset:
      detailList = configureResetList()
    case .basic:
      detailList = configureBasicList()
    case .region:
      detailList = configureRegionList()
    case .size:
      detailList = configureSizeList()
    case .color:
      detailList = configureColorList()
    case .category:
      detailList = configureCategoryList()
    }
    
    var labelList: [UILabel] = []
    for text in detailList {
      let label = UILabel()
      label.text = text
      label.sizeToFit()
      labelList.append(label)
    }
    
    let stackView = UIStackView(arrangedSubviews: labelList)
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    self.addSubview(stackView)

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    stackView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    stackView.backgroundColor = .yellow
  }
  
  private func configureResetList() -> [String] {
    return ["미니", "1호", "2호", "3호", "2단 케이크"]
  }
  
  private func configureBasicList() -> [String] {
    print("configureBasicList")
    var baseicList: [String] = []
    for type in FilterBasic.allCases {
      baseicList.append(type.rawValue)
    }
    return baseicList
  }
  private func configureRegionList() -> [String] {
    print("configureRegionList")
    var baseicList: [String] = []
    for type in FilterRegion.allCases {
      baseicList.append(type.rawValue)
    }
    return baseicList
  }
  private func configureSizeList() -> [String] {
    print("configureSizeList")
    var baseicList: [String] = []
    for type in FilterSize.allCases {
      baseicList.append(type.rawValue)
    }
    return baseicList
  }
  private func configureColorList() -> [String] {
    print("configureColorList")
    var baseicList: [String] = []
    for type in FilterColor.allCases {
      baseicList.append(type.rawValue)
    }
    return baseicList
  }
  private func configureCategoryList() -> [String] {
    print("configureCategoryList")
    var baseicList: [String] = []
    for type in FilterCategory.allCases {
      baseicList.append(type.rawValue)
    }
    return baseicList
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
    
    var name: String {
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
    case whilte = "화이트"
    case pink = "핑크"
    case yellow = "옐로루"
    case red = "레드"
    case blue = "블루"
    case purple = "퍼플"
    case other = "기타"
  }
  
  enum FilterCategory: String, CaseIterable {
    case lettering = "문구"
    case image = "이미지"
    case character = "캐릭터"
    case individuality = "개성"
  }
}
