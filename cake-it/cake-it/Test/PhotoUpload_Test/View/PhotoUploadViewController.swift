//
//  PhotoUploadViewController.swift
//  cake-it
//
//  Created by seungbong on 2021/03/06.
//

import UIKit
import Alamofire

final class PhotoUploadViewController: BaseViewController {
  
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var photoNameLabel: UILabel!
  
  var viewModel: PhotoUploadViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = PhotoUploadViewModel()
  }
  
  @IBAction func sendPhotoButtonDidTap(_ sender: Any) {
    
    guard let imageData = userImage.image?.jpegData(compressionQuality: 0.2) else { return }
    let photoInfo = PhotoUploadModel(name: "이름테스트트", id: 123123, photo: imageData)
    
    guard let url = URL(string: "http://13.124.173.58:8080/api/v2/test/post") else { return }
    let headers: HTTPHeaders = ["Content-Type":"multipart/form-data", "Accept":"application/json"]
    let request = AF.upload(multipartFormData: { (multipartFormData) in
       
      if let param = photoInfo as? PhotoUploadModel {
        multipartFormData.append("\(param.name)".data(using: .utf8)!, withName: "name")
        multipartFormData.append("\(param.id)".data(using: .utf8)!, withName: "id")
        multipartFormData.append(param.photo, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpg")
      }
      
    }, to: url.absoluteString, method: .post, headers: headers)
    
    NetworkManager.shared.request(request: request,
                                  type: PhotoUploadModel.Response.self) { (response) in
      switch response {
      case .success(let result):
        self.nameLabel.text = result.name
        self.idLabel.text = "\(result.id)"
        self.photoNameLabel.text = result.photoName
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
}
