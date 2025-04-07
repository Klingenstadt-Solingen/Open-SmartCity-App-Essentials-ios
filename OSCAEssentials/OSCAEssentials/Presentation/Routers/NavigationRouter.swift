//
//  NavigationRouter.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 18.11.21.
//  Reviewed by Stephan Breidenbach on 19.09.22.
//

import UIKit

/**
 You declare `NavigationRouter` as a subclass of `NSObject`. This is required because you’ll later make this conform to `UINavigationControllerDelegate`.
 */
public class NavigationRouter: NSObject {
  
  private let navigationController: UINavigationController
  private let routerRootController: UIViewController?
  private var onDismissForViewController:
  [UIViewController: (() -> Void)] = [:]
  
  public init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.routerRootController =
    navigationController.viewControllers.first
    super.init()
    navigationController.delegate = self
  }// end public init
  
}// end public class NavigationRouter

extension NavigationRouter {
  func navigateToRoot(animated: Bool) -> Void {
    if routerRootController != nil {
      // is the view controller presented modally?
      if let presentedViewController = navigationController.presentedViewController {
        performOnDismissed(for: presentedViewController)
        navigationController.dismiss(animated: animated)
      }// end if
      let poppedVC = self.navigationController.popToRootViewController(animated: animated)
      if let poppedVC = poppedVC {
        for vc in poppedVC { performOnDismissed(for: vc) }
      }// end if
    } else {
      // there is NO `rootViewController`, so set it to `viewController`
      return
    }// end if
  }// end navigateToRoot
}// end extension public class NavigationRouter

// MARK: - Router conformance
extension NavigationRouter: Router {
  
  public func present(_ viewController: UIViewController,
                      animated: Bool,
                      onDismissed: (() -> Void)?) {
    onDismissForViewController[viewController] = onDismissed
    navigationController.pushViewController(viewController,
                                            animated: animated)
  }// end public func present
  
  public func presentModalViewController(_ viewController: UIViewController,
                                         animated: Bool,
                                         onDismissed: (() -> Void)? = nil) {
    onDismissForViewController[viewController] = onDismissed
    navigationController.present(viewController, animated: animated)
  }// end public func presentModalViewController
  
  public func navigateBack(animated: Bool) {
    if let presentedViewController = navigationController.presentedViewController {
      performOnDismissed(for: presentedViewController)
      navigationController.dismiss(animated: animated)
    } else if let lastViewController = navigationController.viewControllers.last {
      performOnDismissed(for: lastViewController)
      navigationController.popViewController(animated: animated)
    }// end if
  }// end public func navigateBack
  
  public func dismiss(animated: Bool) -> Void{
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    navigateToRoot(animated: false)
    
    guard let vc = self.navigationController.viewControllers.first else { return }
    vc.dismiss(animated: animated){
      self.performOnDismissed(for: vc)
    }// end dismiss
  }// end public func dismiss
  
  private func performOnDismissed(for viewController: UIViewController) {
    
    guard let onDismiss =
            onDismissForViewController[viewController] else {
      return
    }// end guard
    onDismiss()
    onDismissForViewController[viewController] = nil
  }// end performOnDismissed
}// end extension public class NavigationRouter

// MARK: - UINavigationControllerDelegate conformance
extension NavigationRouter: UINavigationControllerDelegate {
  
  /**
   // Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
   @available(iOS 2.0, *)
   optional func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
   
   @available(iOS 2.0, *)
   optional func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool)
   
   
   @available(iOS 7.0, *)
   optional func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask
   
   @available(iOS 7.0, *)
   optional func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation
   
   
   @available(iOS 7.0, *)
   optional func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
   
   
   @available(iOS 7.0, *)
   optional func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
   */
  
  public func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool) {
      
      guard let dismissedViewController =
              navigationController.transitionCoordinator?
        .viewController(forKey: .from),
            !navigationController.viewControllers
        .contains(dismissedViewController) else {
        return
      }
      performOnDismissed(for: dismissedViewController)
    }// end public func navigationController didShow
}// end extension public class NavigationRouter
