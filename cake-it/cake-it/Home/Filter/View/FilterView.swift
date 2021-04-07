//
//  FilterView.swift
//  cake-it
//
//  Created by seungbong on 2021/03/28.
//

import UIKit

protocol FilterViewTestDelegate {
  func filterButtonDidTap(index: Int)
}

class FilterView: UIView {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  
  var delegate: FilterViewTestDelegate?
  var filterList: [String] = [] {
    didSet {
      configureFilterButtonList()
    }
  }
  
  enum FilterRegion: String {
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
  
  enum FilterSize: String {
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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    let view = Bundle.main.loadNibNamed(String(describing: FilterView.self),
                                        owner: self,
                                        options: nil)?.first as! UIView
    
    self.addSubview(view)
  }
  
  private func configureFilterButtonList() {
    var xPos: CGFloat = 20.0
    var filterButtonList: [FilterButton] = []
    for filter in filterList {
      let button = FilterButton(frame:CGRect(x: xPos, y: 0, width: 0, height: 0))
      button.delegate = self
      button.setTitle(filter, for: .normal)
      button.sizeToFit()
      filterButtonList.append(button)
      contentView.addSubview(button)
      xPos += button.frame.width + 10.0
    }
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    contentView.widthAnchor.constraint(equalToConstant: xPos).isActive = true
  }
  
}

extension FilterView: FilterButtonDelegate {
  func filterButtonDidTap(_ sender: UIButton) {
    let testindex = 0
    delegate?.filterButtonDidTap(index: testindex)
  }
}
