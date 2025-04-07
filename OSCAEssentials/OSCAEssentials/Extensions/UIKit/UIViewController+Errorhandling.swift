//
//  UIViewController+Errorhandling.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 19.10.22.
//

import UIKit

public extension UIViewController {
  /// [based upon](https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/)
  func handle(_ error: Error,
              retryHandler: @escaping () -> Void) {
    handle(error, from: self, retryHandler: retryHandler)
  }// end func handle error
}// end public extension UIViewController
