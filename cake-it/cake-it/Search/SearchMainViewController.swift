//
//  SearchMainViewController.swift
//  cake-it
//
//  Created by Cory on 2021/02/16.
//

import UIKit

final class SearchMainViewController: UIViewController {
  
  @IBOutlet weak var searchTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    searchTextField.text = ""
    searchTextField.becomeFirstResponder()
  }
  
  private func configureView() {
    navigationController?.navigationBar.isHidden = true
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(backgroundDidTap))
    view.addGestureRecognizer(tapGesture)
    searchTextField.delegate = self
    searchTextField.tintColor = Colors.pointB
  }
  
  private func search(text: String) {
    // TODO: 서버 검색 api 개발 후 검색기능 구현 필요
    let resultVC = SearchResultViewController.instantiate(from: "Search")
    resultVC.searcingText = text
    self.navigationController?.pushViewController(resultVC, animated: true)
  }
  
  @objc private func backgroundDidTap() {
    searchTextField.resignFirstResponder()
  }
}

extension SearchMainViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.resignFirstResponder()
    search(text: textField.text ?? "")
    return true
  }
}
