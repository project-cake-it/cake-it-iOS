//
//  FilterCommon.swift
//  cake-it
//
//  Created by seungbong on 2021/04/18.
//

import UIKit

final class FilterCommon {
  
  enum Metric {
    static let filterCollectionViewSideContentInset: CGFloat = 16.0
    static let categoryCellLeftInset: CGFloat = 16.0
    static let categoryCellRightInset: CGFloat = 30.0
    static let categoryCellHeight: CGFloat = 35.0
    static let detailViewTopMargin: CGFloat = 7.0
  }
  
  enum FilterType: CaseIterable {
    case reset
    case order
    case region
    case size
    case color
    case category
    case pickupDate
    
    // 서버 api key
    var key: String {
      switch self {
      case .reset:      return "reset"
      case .order:      return "order"
      case .region:     return "location"
      case .size:       return "size"
      case .color:      return "color"
      case .category:   return "category"
      case .pickupDate: return "pickup"
      }
    }
    
    // 필터 버튼 타이틀
    var title: String {
      switch self {
      case .reset:      return "초기화"
      case .order:      return "기본순"
      case .region:     return "지역"
      case .size:       return "크기"
      case .color:      return "색깔"
      case .category:   return "카테고리"
      case .pickupDate: return "주문 가능 날짜"
      }
    }
  }
  
  enum FilterSorting: String, CaseIterable {
    case byDefault  = ""
    case bySaved    = "zzim"
    case byPriceLow = "cheap"

    // 서버 api value
    var value: String {
      return self.rawValue
    }
    
    // 필터 셀 텍스트
    var title: String {
      switch self {
      case .byDefault:    return "기본순"
      case .bySaved:      return "찜 순"
      case .byPriceLow:   return "가격 낮은 순"
      }
    }
  }
  
  enum FilterRegion: String, CaseIterable {
    case gangnam    = "강남구"
    case gangseo    = "강서구"
    case mapo       = "마포구"
    case seodeamun  = "서대문구"
    case songpa     = "송파구"
    
    // 서버 api value
    var value: String {
      return self.rawValue
    }
    
    // 필터 셀 텍스트
    var title: String {
      return self.rawValue
    }
  }
  
  enum FilterSize: String, CaseIterable {
    case miniSize       = "미니"
    case levelOneSize   = "1호"
    case levelTwoSize   = "2호"
    case levelThreeSize = "3호"
    case twoTier        = "2단"
    
    // 서버 api value
    var value: String {
      return self.rawValue
    }
    
    // 필터 셀 텍스트
    var title: String {
      return self.rawValue
    }
    // 필터 셀 하단 텍스트
    var description: String {
      switch self {
      case .miniSize:       return "10-11cm, 1-2인용"
      case .levelOneSize:   return "15-16cm, 3-4인용"
      case .levelTwoSize:   return "18cm, 5-6인용"
      case .levelThreeSize: return "21cm, 7-8인용"
      case .twoTier:        return "파티용 특별제작"
      }
    }
  }
  
  enum FilterColor: String, CaseIterable {
    case white  = "화이트"
    case pink   = "핑크"
    case yellow = "옐로우"
    case red    = "레드"
    case blue   = "블루"
    case purple = "퍼플"
    case other  = "기타"
    
    // 서버 api value
    var value: String {
      return self.rawValue
    }
    
    // 필터 셀 텍스트
    var title: String {
      return self.rawValue
    }
    // 필터 셀 컬러
    var color: UIColor {
      switch self {
      case .white:  return UIColor(named: "design_white")!
      case .pink:   return UIColor(named: "design_pink")!
      case .yellow: return UIColor(named: "design_yellow")!
      case .red:    return UIColor(named: "design_red")!
      case .blue:   return UIColor(named: "design_blue")!
      case .purple: return UIColor(named: "design_purple")!
      case .other:  return UIColor(named: "design_other")!
      }
    }
  }
  
  enum FilterCategory: String, CaseIterable {
    case lettering      = "문구"
    case image          = "이미지"
    case character      = "캐릭터"
    case individuality  = "개성"
    
    // 서버 api value
    var value: String {
      return self.rawValue
    }
    
    // 필터 셀 텍스트
    var title: String {
      return self.rawValue
    }
  }
  
  // TODO: 픽업 가능날짜 enum 구현 필요
  enum FilterPickUpDate: CaseIterable {
    // 서버 api value
    var value: String {
      return "00.00.00"
    }
    
    // 필터 셀 텍스트
    var title: String {
      return "0"
    }
  }
}

// 디자인 리스트 테마
extension FilterCommon {
  enum FilterTheme: String, CaseIterable {
    case birthday       = "생일"
    case anniversary    = "기념일"
    case wedding        = "결혼"
    case emplyment      = "입사"
    case advancement    = "승진"
    case leave          = "퇴사"
    case discharge      = "전역"
    case graduated      = "졸업"
    case rehabilitation = "복직"
    
    // 서버 api value
    static var key: String {
      return "theme"
    }
    
    // 서버 api value
    var value: String {
      return self.rawValue
    }
    
    // 필터 셀 텍스트
    var title: String {
      return self.rawValue
    }
  }
}

// 통합검색 키워드
extension FilterCommon {
  enum Searching: CaseIterable {
    // 서버 api value
    static var key: String {
      return "keyword"
    }
  }
}
