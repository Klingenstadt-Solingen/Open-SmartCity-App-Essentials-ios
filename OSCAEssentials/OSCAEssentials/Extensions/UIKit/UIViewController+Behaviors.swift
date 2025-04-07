//
//  UIViewController+Behaviors.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.04.21.
//

// based upon https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3
// View controller lifecycle behaviors https://irace.me/lifecycle-behaviors
// Behaviors are very useful to reuse logic for cases like Keyboard Behaviour.
// Where ViewController on didLoad adds behaviour which observes keyboard frame
// and scrollView content inset changes based on keyboard frame.

import UIKit

public protocol ViewControllerLifecycleBehavior {
  func viewDidLoad(viewController: UIViewController)
  func viewWillAppear(viewController: UIViewController)
  func viewDidAppear(viewController: UIViewController)
  func viewWillDisappear(viewController: UIViewController)
  func viewDidDisappear(viewController: UIViewController)
  func viewWillLayoutSubviews(viewController: UIViewController)
  func viewDidLayoutSubviews(viewController: UIViewController)
}// end protocol ViewControllerLifecycleBehavior

// Default implementations
public extension ViewControllerLifecycleBehavior {
  func viewDidLoad(viewController: UIViewController) {}
  func viewWillAppear(viewController: UIViewController) {}
  func viewDidAppear(viewController: UIViewController) {}
  func viewWillDisappear(viewController: UIViewController) {}
  func viewDidDisappear(viewController: UIViewController) {}
  func viewWillLayoutSubviews(viewController: UIViewController) {}
  func viewDidLayoutSubviews(viewController: UIViewController) {}
}// end extension protocol ViewControllerLifecycleBehavior

public extension UIViewController {
  /*
   Add behaviors to be hooked into this view controller’s lifecycle.
   
   This method requires the view controller’s view to be loaded, so it’s best to call
   in `viewDidLoad` to avoid it being loaded prematurely.
   
   - parameter behaviors: Behaviors to be added.
   */
  func addBehaviors(_ behaviors: [ViewControllerLifecycleBehavior]) {
    let behaviorViewController = LifecycleBehaviorViewController(behaviors: behaviors)
    
    addChild(behaviorViewController)
    view.addSubview(behaviorViewController.view)
    behaviorViewController.didMove(toParent: self)
  }// end func addBehaviors
  
  private final class LifecycleBehaviorViewController: UIViewController, UIGestureRecognizerDelegate {
    private let behaviors: [ViewControllerLifecycleBehavior]
    
    // MARK: - Lifecycle
    
    init(behaviors: [ViewControllerLifecycleBehavior]) {
      self.behaviors = behaviors
      
      super.init(nibName: nil, bundle: nil)
    }// end init
    
    required init?(coder aDecoder: NSCoder) {
#warning("TODO: fatalError")
      fatalError("init(coder:) has not been implemented")
    }// end required init
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      view.isHidden = true
      
      applyBehaviors { behavior, viewController in
        behavior.viewDidLoad(viewController: viewController)
      }// end applyBehaviors
    }// end func viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      applyBehaviors { behavior, viewController in
        behavior.viewWillAppear(viewController: viewController)
      }// end applyBahaviors
    }// end override func viewWillAppear
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      applyBehaviors { behavior, viewController in
        behavior.viewDidAppear(viewController: viewController)
      }// end applyBehaviors
    }// end override func viewDidAppear
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      applyBehaviors { behavior, viewController in
        behavior.viewWillDisappear(viewController: viewController)
      }// end applyBahavours
    }// end func viewWillDisappear
    
    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      
      applyBehaviors { behavior, viewController in
        behavior.viewDidDisappear(viewController: viewController)
      }// end applyBahavors
    }// end override func viewDidDisappear
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      
      applyBehaviors { behavior, viewController in
        behavior.viewWillLayoutSubviews(viewController: viewController)
      }// end applyBehaviors
    }// end override func viewWillLayoutSubviews
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      
      applyBehaviors { behavior, viewController in
        behavior.viewDidLayoutSubviews(viewController: viewController)
      }// end applyBehaviors
    }// end override func viewDidLayoutSubviews
    
    // MARK: - Private
    
    private func applyBehaviors(body: (_ behavior: ViewControllerLifecycleBehavior,
                                       _ viewController: UIViewController) -> Void) {
      guard let parent = parent else { return }
      
      for behavior in behaviors {
        body(behavior, parent)
      }// end for behavior in behaviors
    }// end func applyBehaviors
  }// end final class LifecycleBehaviorViewController
}// end extension UIViewController
