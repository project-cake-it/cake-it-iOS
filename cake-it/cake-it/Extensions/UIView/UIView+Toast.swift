//
//  UIView+Toast.swift
//  cake-it
//
//  Created by seungbong on 2021/08/01.
//

import UIKit

extension UIView {
  func showToastMessage(message: String,
                        durationTime: Double = 0.7,
                        delayTime: Double = 3.0,
                        completion: (()->Void)? = nil) {
    
    let alpahValue: CGFloat = 0.8
    let toastView = initToastView(message: message)
    
    UIView.animate(withDuration: durationTime, animations: {
      toastView.alpha = alpahValue
    }, completion: { _ in
      UIView.animate(withDuration: durationTime, delay: delayTime, animations: {
        toastView.alpha = 0.0
      }, completion: { _ in
        toastView.removeFromSuperview()
        if let completion = completion {
          completion()
        }
      })
    })
  }
  
  private func initToastView(message: String) -> UIView {
    let toastView = UIView()
    toastView.backgroundColor = .black
    toastView.alpha = 0.7
    toastView.clipsToBounds = false
    toastView.layer.cornerRadius = 15
    self.addSubview(toastView)

    let label = UILabel()
    label.text = message
    label.textColor = UIColor.white
    label.textAlignment = .center
    label.font = Fonts.spoqaHanSans(weight: .Regular, size: 14.0)
    label.numberOfLines = 0
    label.lineBreakMode = .byCharWrapping
    label.sizeToFit()
    toastView.addSubview(label)

    let bottomMargin: CGFloat = 50.0
    let horizentalPadding: CGFloat = 30.0
    let verticalPadding: CGFloat = 15.0

    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                    constant: -bottomMargin),
      label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      label.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor,
                                     constant: horizentalPadding),
      label.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor,
                                      constant: -horizentalPadding)
    ])

    toastView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      toastView.centerXAnchor.constraint(equalTo: label.centerXAnchor),
      toastView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
      toastView.widthAnchor.constraint(equalTo: label.widthAnchor,
                                     constant: horizentalPadding),
      toastView.heightAnchor.constraint(greaterThanOrEqualTo: label.heightAnchor,
                                      constant: verticalPadding)
    ])
    
    return toastView
  }
}
