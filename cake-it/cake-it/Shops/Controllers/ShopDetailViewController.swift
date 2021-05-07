//
//  ShopDetailViewController.swift
//  cake-it
//
//  Created by Cory on 2021/05/08.
//

import UIKit

final class ShopDetailViewController: UIViewController {
  
  @IBOutlet weak var shopNameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var savedCountLabel: UILabel!
  @IBOutlet weak var showAvailableDateButton: UIButton!
  
  @IBOutlet weak var themeLabel: UILabel!
  @IBOutlet weak var priceInfoBySizeStackView: UIStackView!
  @IBOutlet weak var creamInfoLabel: UILabel!
  @IBOutlet weak var sheetInfoLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    dismiss(animated: false, completion: nil)
  }
}

// MARK: - Configuration

extension ShopDetailViewController {
  private func configure() {
    configureViews()
  }
  
  private func configureViews() {
    showAvailableDateButton.layer.borderWidth = 1.0
    showAvailableDateButton.layer.borderColor = Colors.pointB.cgColor
    showAvailableDateButton.round(cornerRadius: 4.0, clipsToBounds: true)
  }
}
