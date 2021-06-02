//
//  FilterCommon.swift
//  cake-it
//
//  Created by seungbong on 2021/04/18.
//

import UIKit

final class FilterCommon {
  
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
    
    var korTitle: String {
      switch self {
      case .reset:    return "초기화"
      case .basic:    return "기본순"
      case .region:   return "지역"
      case .size:     return "크기"
      case .color:    return "색깔"
      case .category: return "카테고리"
      }
    }
  }
  
  enum FilterSorting: String, CaseIterable {
    case byDefault = "기본순"
    case bySaved = "찜 순"
    case byPriceHigh = "가격 높은 순"
    case byPriceLow = "가격 낮은 순"
    
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
    case miniSize = "미니"
    case levelOneSize = "1호"
    case levelTwoSize = "2호"
    case levelThreeSize = "3호"
    case twoTier = "2단"
    
    var title: String {
      return self.rawValue
    }
    
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
    case lettering = "문구"
    case image = "이미지"
    case character = "캐릭터"
    case individuality = "개성"
    
    var title: String {
      return self.rawValue
    }
  }
}
