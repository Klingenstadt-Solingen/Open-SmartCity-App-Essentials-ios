//
//  UIResponder.swift
//  OSCASolingen
//
//  Created by Stephan Breidenbach on 19.10.22.
//

import UIKit

// MARK: - error propagation
extension UIResponder {
  /// We're dispatching our new method through the Objective-C
  /// runtime, to enable us to override it within subclasses:
  /// [based upon](https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/)
  @objc open func handle(_ error: Error,
                         from viewController: UIViewController? = nil,
                         retryHandler: @escaping () -> Void) {
    // This assertion will help us identify errors that were
    // either emitted by a view controller *before* it was
    // added to the responder chain, or never handled at all:
    guard let nextResponder = next else {
      if let viewController = viewController {
        return assertionFailure("""
            Unhandled error \(error) from \(viewController)
            """)
      } else {
        return assertionFailure("""
            Unhandled error \(error)
            """)
      }
      
    }// end guard
    
    nextResponder.handle(error,
                         from: viewController,
                         retryHandler: retryHandler
    )// end handle
  }// end @objc func handle
}// end extension class UIResponder
