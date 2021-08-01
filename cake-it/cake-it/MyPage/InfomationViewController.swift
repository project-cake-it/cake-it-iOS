//
//  InfomationViewController.swift
//  cake-it
//
//  Created by theodore on 2021/05/08.
//

import UIKit
import WebKit

final class InfomationViewController: BaseViewController {
  
  @IBOutlet private weak var viewTitleLabel: UILabel!
  @IBOutlet weak var webView: WKWebView!
  
  private var url: URL?
  private var titleText: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let targetUrl = url else { return }
    
    let request = URLRequest(url: targetUrl)
    webView.scrollView.bounces = false
    webView.load(request);
    
    guard let titleText = titleText else { return }
    viewTitleLabel.text = titleText
  }
  
  func configureViewController(url: URL, title: String) {
    self.url = url
    titleText = title
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}
