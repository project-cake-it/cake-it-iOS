//
//  SearchMainViewController.swift
//  cake-it
//
//  Created by Cory on 2021/02/16.
//

import UIKit

final class SearchMainViewController: BaseViewController {
  
  @IBOutlet weak var searchTextField: UITextField!
  
  var searchResult: SearchResult?
  
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
  
  @objc private func backgroundDidTap() {
    searchTextField.resignFirstResponder()
  }
}

// MARK:- Private Fuction
extension SearchMainViewController {
  private func search(text: String) {
    requestSearch(searchText: text, complition: { (isSuccess) in
      if isSuccess == true {
        let resultVC = SearchResultViewController.instantiate(from: "Search")
        resultVC.keyword = text
        resultVC.searchResult = self.searchResult
        self.navigationController?.pushViewController(resultVC, animated: true)
      }
    })
  }
  
  private func requestSearch(searchText: String,
                             complition: @escaping (Bool)->Void) {
    let parameter = ["keyword": searchText].queryString()
    NetworkManager.shared.requestGet(api: .search,
                                     type: SearchResult.self,
                                     param: parameter) { (response) in
      switch response {
      case .success(let result) :
        self.searchResult = result
        complition(true)
      case .failure(let error) :
        // TODO: Error Handeling
        print(error.localizedDescription)
        complition(false)
      }
    }
  }
}


// MARK:- TextField Delegate
extension SearchMainViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.resignFirstResponder()
    search(text: textField.text ?? "")
    return true
  }
}
