//
//  WebViewController.swift
//  cake-it
//
//  Created by Cory on 2021/07/03.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
  
  enum Metric {
    static let navigationBarViewHeight: CGFloat = 60.0
    static let rightButtonSize: CGFloat = 48.0
  }
  
  private var navigationBarView: UIView!
  private var webView = WKWebView()
  private var activityIndicator = UIActivityIndicatorView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  func set(url: URL) {
    let urlRequest = URLRequest(url: url)
    webView.load(urlRequest)
  }
}

extension WebViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    activityIndicator.isHidden = false
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    activityIndicator.stopAnimating()
    activityIndicator.isHidden = true
  }
}

// MARK: - Configuration

extension WebViewController {
  private func configure() {
    configureViews()
  }
  
  private func configureViews() {
    configureNavigationBarView()
    configureNavigationBarRightButton()
    configureWebView()
    configureActivityIndicatorView()
  }
  
  private func configureNavigationBarView() {
    navigationBarView = UIView()
    navigationBarView.backgroundColor = Colors.white
    view.addSubview(navigationBarView)
    navigationBarView.constraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                  leadingAnchor: view.leadingAnchor,
                                  bottomAnchor: nil,
                                  trailingAnchor: view.trailingAnchor,
                                  size: .init(width: 0, height: Metric.navigationBarViewHeight))
    let statusBarCoverView = UIView()
    statusBarCoverView.backgroundColor = Colors.white
    view.addSubview(statusBarCoverView)
    statusBarCoverView.constraints(topAnchor: view.topAnchor,
                                   leadingAnchor: view.leadingAnchor,
                                   bottomAnchor: navigationBarView.topAnchor,
                                   trailingAnchor: view.trailingAnchor)
  }
  
  private func configureNavigationBarRightButton() {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "arrowLeft"), for: .normal)
    button.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
    button.tintColor = Colors.grayscale04
    navigationBarView.addSubview(button)
    button.constraints(topAnchor: navigationBarView.topAnchor,
                       leadingAnchor: nil,
                       bottomAnchor: navigationBarView.bottomAnchor,
                       trailingAnchor: navigationBarView.trailingAnchor,
                       padding: .init(top: 0, left: 0, bottom: 0, right: 8),
                       size: .init(width: Metric.rightButtonSize, height: Metric.rightButtonSize))
  }
  
  @objc private func dismissButtonDidTap() {
    dismiss(animated: true, completion: nil)
  }
  
  private func configureWebView() {
    webView.navigationDelegate = self
    view.addSubview(webView)
    webView.constraints(topAnchor: navigationBarView.bottomAnchor,
                        leadingAnchor: view.leadingAnchor,
                        bottomAnchor: view.bottomAnchor,
                        trailingAnchor: view.trailingAnchor)
  }
  
  private func configureActivityIndicatorView() {
    activityIndicator.tintColor = Colors.pointB
    activityIndicator.startAnimating()
    view.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
  }
}
