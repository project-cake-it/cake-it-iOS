//
//  CakeDesignDetailContactButton.swift
//  cake-it
//
//  Created by Cory on 2021/05/19.
//

import UIKit

final class CakeDesignDetailContactButton: UIButton {
  
  enum State {
    case floating
    case hidden
  }
  
  var displayState: State = .floating
}
