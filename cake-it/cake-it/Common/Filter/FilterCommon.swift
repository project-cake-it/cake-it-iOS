//
//  FilterCommon.swift
//  cake-it
//
//  Created by seungbong on 2021/04/18.
//

import UIKit

final class FilterCommon {
  
  enum FilterType: String, CaseIterable {
    case reset    = "reset"
    case basic    = "order"
    case region   = "location"
    case size     = "size"
    case color    = "color"
    case category = "category"
    
    var value: String {
      return self.rawValue
    }
    
    var title: String {
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
    case byDefault    = "DEFAULT"
    case bySaved      = "ZZIM"
    case byPriceHigh  = "HIGH_PRICE"
    case byPriceLow   = "LOW_PRICE"

    var value: String {
      return self.rawValue
    }
    
    var title: String {
      switch self {
      case .byDefault:    return "기본순"
      case .bySaved:      return "찜 순"
      case .byPriceHigh:  return "가격 높은 순"
      case .byPriceLow:   return "가격 낮은 순"
      }
    }
  }
  
  enum FilterRegion: String, CaseIterable {
    case gangnam   = "강남구"
    case gwangjin  = "광진구"
    case gwanak    = "관악구"
    case mapo      = "마포구"
    case seodeamun = "서대문구"
    case songpa    = "송파구"
    
    var value: String {
      return self.rawValue
    }
    
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
  
  enum FilterSize: String, CaseIterable {
    case miniSize       = "미니"
    case levelOneSize   = "1호"
    case levelTwoSize   = "2호"
    case levelThreeSize = "3호"
    case twoTier        = "2단"
    
    var value: String {
      return self.rawValue
    }
    
    var title: String {
      switch self {
      case .miniSize:       return "미니"
      case .levelOneSize:   return "1호"
      case .levelTwoSize:   return "2호"
      case .levelThreeSize: return "3호"
      case .twoTier:        return "2단"
      }
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
    case white  = "WHITE"
    case pink   = "PINK"
    case yellow = "YELLOW"
    case red    = "RED"
    case blue   = "BLUE"
    case purple = "PURPLE"
    case other  = "OTHER"
    
    var value: String {
      return self.rawValue
    }
    
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
    case lettering      = "WORDING"
    case image          = "IMAGE"
    case character      = "CHARACTERS"
    case individuality  = "INDIVIDUALITY"
    
    var value: String {
      return self.rawValue
    }
    
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
