//
//  FilterCommon.swift
//  cake-it
//
//  Created by seungbong on 2021/04/18.
//

import UIKit

final class FilterCommon {
  
  enum Metric {
    static let categoryCellLeftMargin: CGFloat = 16.0
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
      case .pickupDate: return "픽업 가능 날짜"
      }
    }
  }
  
  enum FilterSorting: CaseIterable {
    case byDefault
    case bySaved
    case byPriceLow

    // 서버 api value
    var value: String {
      switch self {
      case .byDefault:    return ""
      case .bySaved:      return "zzim"
      case .byPriceLow:   return "cheap"
      }
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
      case .white:  return "화이트"
      case .pink:   return "핑크"
      case .yellow: return "옐로우"
      case .red:    return "레드"
      case .blue:   return "블루"
      case .purple: return "퍼플"
      case .other:  return "기타"
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
      case .lettering:     return "문구"
      case .image:         return "이미지"
      case .character:     return "캐릭터"
      case .individuality: return "개성"
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
  
  enum FilterTheme: CaseIterable {
    case birthday
    case anniversary
    case wedding
    case emplyment
    case advancement
    case leave
    case discharge
    case graduated
    case rehabilitation
    
    // 서버 api value
    static var key: String {
      return "theme"
    }
    
    // 서버 api value
    var value: String {
      switch self {
      case .birthday:     	return "생일"
      case .anniversary:  	return "기념일"
      case .wedding:        return "결혼"
      case .emplyment:      return "입사"
      case .advancement:    return "승진"
      case .leave:          return "퇴사"
      case .discharge:      return "전역"
      case .graduated:      return "졸업"
      case .rehabilitation: return "복직"
      }
    }
    
    // 필터 셀 텍스트
    var title: String {
      switch self {
      case .birthday:       return "생일"
      case .anniversary:    return "기념일"
      case .wedding:        return "결혼"
      case .emplyment:      return "입사"
      case .advancement:    return "승진"
      case .leave:          return "퇴사"
      case .discharge:      return "전역"
      case .graduated:      return "졸업"
      case .rehabilitation: return "복직"
      }
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
