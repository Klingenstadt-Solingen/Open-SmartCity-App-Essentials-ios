//
//  Router.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.09.21.
//
import UIKit

// MARK: - Router protocol
/**
 The `Router`is a protocol that defines methods all concrete routers must implement. Specifically, it defines `present`and `dismiss`methods for showing and disissing view controllers.
 */
public protocol Router: AnyObject {
  /**
   `present` method to show the `viewController` with animation (`animated` true) or without animation (`animated` false)
     */
  func present(_ viewController: UIViewController,
               animated: Bool) -> Void
                
    /**
     `present` method to show the `viewController` with animation (`animated` true) or without animation (`animated` false) with `onDismissed` closure which is invoked after the `viewController` is dismissed.
       */
  func present(_ viewController: UIViewController,
               animated: Bool,
               onDismissed: (() -> Void)?) -> Void
  /**
   `presentModalViewController` method to show the `viewController` modally with animation (`animated` true) or without animation (`animated` false)
  */
  func presentModalViewController(_ viewController: UIViewController,
                                  animated: Bool,
                                  onDismissed: (() -> Void)?) -> Void
  /**
   `navigateBack` method to `pop` or `dismiss` the current `viewController` on the navigation stack with animation (`animated` true) or without animation (`animated` false)
  */
  func navigateBack(animated: Bool) -> Void
  /**
     This will dismiss the *entire*  router. Depending on the concrete router, this may result in popping to a root view controller, calling `dismiss`on a `parentViewController`or whatever action is necessary per the concrete router's implementation
     */
  func dismiss(animated: Bool) -> Void
}// end public protocol Router: AnyObject

// MARK: - Router default implementation
extension Router {
  /**
     You lastly define a default implementation for `present(_:animated:)`. This simply calls the other `present`by passing `nil`for `onDismissed`
     */
  public func present(_ viewController: UIViewController,
                      animated: Bool) {
    #if DEBUG
    print("\(String(describing: self)): \(#function)")
    #endif
    present(viewController,
            animated: animated,
            onDismissed: nil)
  }// end public func present
    
  public func presentModalViewController(_ viewController: UIViewController,
                                         animated: Bool) {

      presentModalViewController(viewController,
                                 animated: animated,
                                 onDismissed: nil)
  }

  public func navigateBack(animated: Bool) {
      navigateBack(animated: animated)
  }
}// end extension protocol Router
