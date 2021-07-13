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
  
  var url: URL?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let targetUrl = url else { return }
    
    let request = URLRequest(url: targetUrl)
    webView.scrollView.bounces = false
    webView.load(request);
  }
  
  @IBAction func backButtonDidTap(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}
