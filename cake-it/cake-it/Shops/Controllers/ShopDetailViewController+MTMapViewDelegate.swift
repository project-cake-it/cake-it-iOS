//
//  ShopDetailViewController+MTMapViewDelegate.swift
//  cake-it
//
//  Created by theodore on 2021/07/16.
//

import UIKit

extension ShopDetailViewController: MTMapViewDelegate {
  func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
    return true
  }
}
