//
//  ModalNavigationRouter.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.09.21.
//
import UIKit
/**
 You declare `ModalNavigationRouter`as a subclass of `NSObject`. This is required because you will later make this conform to `UINavigationControllerDelegate`.
 */
public class ModalNavigationRouter: NSObject {
  // MARK: - Instance Properties
  public unowned let parentViewController: UIViewController
  /**
   `navigationController`will be used to push and pop view controllers.
   */
  private let navigationController: UINavigationController =  UINavigationController()
  
  /**
   `onDismissForViewController`is a mapping from `UIViewController`to on-dismiss closures. You will use this later to perform on-dismiss actions whenever view controllers are popped.
   */
  private var onDismissForViewController:
  [UIViewController: (() -> Void)] = [:]
  
  /**
   You lastly create an initializer that takes a `navigationController`, and you set the `navigationController `and `routerRootController` from it.
   */
  public init(parentViewController: UIViewController) {
#if DEBUG
    print("\(String(describing: Self.self)): \(#function)")
#endif
    self.parentViewController = parentViewController
    super.init()
    self.navigationController.delegate = self
  }// end public init
}// end public class ModalNavigationRouter

// MARK: - Router
extension ModalNavigationRouter: Router {
  /**
   Within `present(_:animated_onDismissed:)`, you set the `onDismissed`closure for the given `viewController`and then push the view controlller on to the `navigationController`to show it.
   */
  public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    self.onDismissForViewController[viewController] = onDismissed
    if self.navigationController.viewControllers.count == 0 {
      self.presentModalViewController(viewController, animated: animated)
      
    } else {
      self.navigationController.pushViewController(viewController, animated: animated)
    }
  }
  
  public func presentModalViewController(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    self.addCancelButton(to: viewController)
    self.navigationController.setViewControllers([viewController], animated: animated)
    self.parentViewController.present(self.navigationController,
                                      animated: animated,
                                      completion: onDismissed)
  }
  
  private func addCancelButton(to viewController: UIViewController) -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    let barButton = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(self.cancelPressed))
    viewController.navigationItem.leftBarButtonItem = barButton
  }// end private func addCancleButton
  
  @objc private func cancelPressed() -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    performOnDismissed( for: self.navigationController.viewControllers.first!)
    dismiss(animated: true)
  }// end @objc private func canclePressed
  
  public func navigateBack(animated: Bool) {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    // is the view controller presented modally?
    if let presentedViewController = navigationController.presentedViewController {
      self.performOnDismissed(for: presentedViewController)
      self.navigationController.dismiss(animated: animated)
      
    } else if let lastViewController = navigationController.viewControllers.last {
      self.performOnDismissed(for: lastViewController)
      self.navigationController.popViewController(animated: animated)
    }
  }
  
  public func dismiss(animated: Bool) -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    performOnDismissed(for: self.navigationController.viewControllers.first!)
    parentViewController.dismiss(animated: animated,
                                 completion: nil)
  }// end public func dismiss
  
  /**
   Within `performOnDismiss(for:)`, you guard that there is an `onDismiss`for the given `viewController`. If not, you simply `return`early. Otherwise, you call `onDismiss`and remove it from `onDismissForViewController`
   */
  private func performOnDismissed(for
                                  viewController: UIViewController) {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    guard let onDismiss =
            self.onDismissForViewController[viewController] else {
      return
    }// end guard
    onDismiss()
    self.onDismissForViewController[viewController] = nil
  }// end private func performOnDismissed
}// end extension class ModalNavigationRouter: Router

// MARK: - UINavigationControllerDelegate
extension ModalNavigationRouter: UINavigationControllerDelegate {
  
  /**
   You get the `from`view controller from the `navigationController.transitionCoordinator`and verify it's not contained within `navigationController.viewControllers`. This indicates that the view controller was popped, and in response, you call `performOnDismissed`to do tho on-dismiss action for the given view controller.
   */
  public func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool) {
#if DEBUG
      print("\(String(describing: self)): \(#function)")
#endif
      guard let dismissedViewController = self.navigationController.transitionCoordinator?.viewController(forKey: .from),
            !self.navigationController.viewControllers.contains(dismissedViewController) else { return }// end guard
      performOnDismissed(for: dismissedViewController)
    }// end public func navigationController
}// end extension class ModalNavigationRouter: UINavigationControllerDelegate

