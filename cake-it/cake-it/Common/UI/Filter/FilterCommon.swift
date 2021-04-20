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
    
    var kor_title: String {
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
