//
//  FilterCommon.swift
//  cake-it
//
//  Created by seungbong on 2021/04/18.
//

import UIKit

final class FilterCommon {
  
  enum FilterType: CaseIterable {
    case reset
    case order
    case region
    case size
    case color
    case category
    
    // 서버 api key
    var key: String {
      switch self {
      case .reset:    return "reset"
      case .order:    return "order"
      case .region:   return "location"
      case .size:     return "size"
      case .color:    return "color"
      case .category: return "category"
      }
    }
    
    // 필터 버튼 타이틀
    var title: String {
      switch self {
      case .reset:    return "초기화"
      case .order:    return "기본순"
      case .region:   return "지역"
      case .size:     return "크기"
      case .color:    return "색깔"
      case .category: return "카테고리"
      }
    }
  }
  
  enum FilterSorting: CaseIterable {
    case byDefault
    case bySaved
    case byPriceHigh
    case byPriceLow

    // 서버 api value
    var value: String {
      switch self {
      case .byDefault:    return "DEFAULT"
      case .bySaved:      return "ZZIM"
      case .byPriceHigh:  return "HIGH_PRICE"
      case .byPriceLow:   return "LOW_PRICE"
      }
    }
    
    // 필터 셀 텍스트
    var title: String {
      switch self {
      case .byDefault:    return "기본순"
      case .bySaved:      return "찜 순"
      case .byPriceHigh:  return "가격 높은 순"
      case .byPriceLow:   return "가격 낮은 순"
      }
    }
  }
  
  enum FilterRegion: CaseIterable {
    case gangnam
    case gwangjin
    case gwanak
    case mapo
    case seodeamun
    case songpa
    
    // 서버 api value
    var value: String {
      switch self {
      case .gangnam:    return "강남구"
      case .gwangjin:   return "광진구"
      case .gwanak:     return "관악구"
      case .mapo:       return "마포구"
      case .seodeamun:  return "서대문구"
      case .songpa:     return "송파구"
      }
    }
    
    // 필터 셀 텍스트
    var title: String {
      switch self {
      case .gangnam:    return "강남구"
      case .gwangjin:   return "광진구"
      case .gwanak:     return "관악구"
      case .mapo:       return "마포구"
      case .seodeamun:  return "서대문구"
      case .songpa:     return "송파구"
      }
    }
  }
  
  enum FilterSize: CaseIterable {
    case miniSize
    case levelOneSize
    case levelTwoSize
    case levelThreeSize
    case twoTier
    
    // 서버 api value
    var value: String {
      switch self {
      case .miniSize:       return "미니"
      case .levelOneSize:   return "1호"
      case .levelTwoSize:   return "2호"
      case .levelThreeSize: return "3호"
      case .twoTier:        return "2단"
      }
    }
    
    // 필터 셀 텍스트
    var title: String {
      switch self {
      case .miniSize:       return "미니"
      case .levelOneSize:   return "1호"
      case .levelTwoSize:   return "2호"
      case .levelThreeSize: return "3호"
      case .twoTier:        return "2단"
      }
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
  
  enum FilterColor: CaseIterable {
    case white
    case pink
    case yellow
    case red
    case blue
    case purple
    case other
    
    // 서버 api value
    var value: String {
      switch self {
      case .white:  return "WHITE"
      case .pink:   return "PINK"
      case .yellow: return "YELLOW"
      case .red:    return "RED"
      case .blue:   return "BLUE"
      case .purple: return "PURPLE"
      case .other:  return "OTHER"
      }
    }
    
    // 필터 셀 텍스트
    var title: String {
      switch self {
      case .white:  return "화이트"
      case .pink:   return "핑크"
      case .yellow: return "옐로우"
      case .red:    return "레드"
      case .blue:   return "블루"
      case .purple: return "퍼플"
      case .other:  return "기타"
      }
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
  
  enum FilterCategory: CaseIterable {
    case lettering
    case image
    case character
    case individuality
    
    // 서버 api value
    var value: String {
      switch self {
      case .lettering:     return "WORDING"
      case .image:         return "IMAGE"
      case .character:     return "CHARACTERS"
      case .individuality: return "INDIVIDUALITY"
      }
    }
    
    // 필터 셀 텍스트
    var title: String {
      switch self {
      case .lettering:     return "문구"
      case .image:         return "이미지"
      case .character:     return "캐릭터"
      case .individuality: return "개성"
      }
    }
  }
}
