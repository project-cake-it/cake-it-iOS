//
//  FilterDetailView.swift
//  cake-it
//
//  Created by seungbong on 2021/04/06.
//

import Foundation
import UIKit

protocol FilterDetailViewDelegate {
  func filterDidSelected(key: FilterCommon.FilterType, value: String)
}

class FilterDetailView: UIView {
  
  @IBOutlet weak var backgroundView: UIView!
  
  var delegate: FilterDetailViewDelegate?
  var filterType: FilterCommon.FilterType = .reset {
    didSet {
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
    
    for i in 0..<FilterCommon.FilterBasic.allCases.count {
      let baseCell = TitleFilterCell(frame: CGRect(x: 0, y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: 40))
      baseCell.delegate = self
      baseCell.filterIndex = i
      baseCell.label.text = FilterCommon.FilterBasic.allCases[i].title
      viewList.append(baseCell)
    }
    
    return viewList
  }
  
  private func configureRegionList() -> [UIView] {
    var viewList: [TitleFilterCell] = []
    
    for i in 0..<FilterCommon.FilterRegion.allCases.count {
      let regionCell = TitleFilterCell(frame: CGRect(x: 0, y: 0,
                                                     width: UIScreen.main.bounds.width,
                                                     height: 40))
      regionCell.delegate = self
      regionCell.filterIndex = i
      regionCell.label.text = FilterCommon.FilterRegion.allCases[i].title
      viewList.append(regionCell)
    }
    
    return viewList
  }
  
  private func configureSizeList() -> [UIView] {
    var viewList: [UIView] = []
    
    for i in 0..<FilterCommon.FilterSize.allCases.count {
      let descriptionCell = DescriptionFilterCell(frame: CGRect(x: 0, y: 0,
                                                                width: UIScreen.main.bounds.width,
                                                                height: 60))
      descriptionCell.delegate = self
      descriptionCell.filterIndex = i
      descriptionCell.titleLabel.text = FilterCommon.FilterSize.allCases[i].title
      descriptionCell.descriptionLabel.text = FilterCommon.FilterSize.allCases[i].description
      viewList.append(descriptionCell)
    }
    
    return viewList
  }
  
  private func configureColorList() -> [UIView] {
    var viewList: [ColorFilterCell] = []
    
    for i in 0..<FilterCommon.FilterColor.allCases.count {
      let colorCell = ColorFilterCell(frame: CGRect(x: 0, y: 0,
                                                    width: UIScreen.main.bounds.width,
                                                    height: 40))
      colorCell.delegate = self
      colorCell.filterIndex = i
      colorCell.colorLabel.text = FilterCommon.FilterColor.allCases[i].title
      colorCell.colorView.backgroundColor = FilterCommon.FilterColor.allCases[i].color
      viewList.append(colorCell)
    }
    
    return viewList
  }
  
  private func configureCategoryList() -> [UIView] {
    var viewList: [TitleFilterCell] = []
    
    for i in 0..<FilterCommon.FilterCategory.allCases.count {
      let baseCell = TitleFilterCell(frame: CGRect(x: 0, y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: 40))
      baseCell.delegate = self
      baseCell.filterIndex = i
      baseCell.label.text = FilterCommon.FilterCategory.allCases[i].title
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
      value = FilterCommon.FilterBasic.allCases[index].title
    case .region:
      value = FilterCommon.FilterRegion.allCases[index].title
    case .size:
      value = FilterCommon.FilterSize.allCases[index].title
    case .color:
      value = FilterCommon.FilterColor.allCases[index].title
    case .category:
      value = FilterCommon.FilterCategory.allCases[index].title
    case .reset:
      break
    }
    
    delegate?.filterDidSelected(key: filterType, value: value)
  }
}
