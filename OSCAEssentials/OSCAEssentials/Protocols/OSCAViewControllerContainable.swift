//
//  OSCAViewControllerContainable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 23.03.22.
//

import UIKit

public protocol OSCAViewControllerContainable: NSObjectProtocol {
    var containerView: UIView? { get set }
    func embed(_ childViewController: OSCAViewControllerEmbeddable) -> Void
    func desembed(_ childViewController: OSCAViewControllerEmbeddable) -> Void
}// end public protocol

extension OSCAViewControllerContainable where Self: UIViewController {
    /// embed a child view controller in the container view
    /// [see Apple Docs](https://developer.apple.com/documentation/uikit/view_controllers/creating_a_custom_container_view_controller)
    /// [adding child view controller](https://tanaschita.com/20200215-adding-childview-controller/)
    public func embed(_ childViewController: OSCAViewControllerEmbeddable) -> Void {
        guard let childVC = childViewController as? UIViewController,
              let containerView = self.containerView else { return }
        // create the constraints for the child's view
        let matchParentConstraints = [
            childVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            childVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]// end matchParentConstraints
        
        // add the view controller to the container
        addChild(childVC)
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childVC.view)
        // activate the constraints for the child's view.
        NSLayoutConstraint.activate(matchParentConstraints)
        // Notify the child view controller that the move is complete.
        childVC.didMove(toParent: self)
    }// end mutating func embed child view controller
    
    /// remove a child view controller from the container view
    /// [see Apple Docs](https://developer.apple.com/documentation/uikit/view_controllers/creating_a_custom_container_view_controller)
    public func desembed(_ childViewController: OSCAViewControllerEmbeddable) -> Void {
        guard let childVC = childViewController as? UIViewController else { return }
        // parent to nil
        childVC.willMove(toParent: nil)
        // deactivate or remove any constraints for the child's root view
        
        // remove child's root view from view hierarchy
        childVC.view.removeFromSuperview()
        
        // finalize the end of the container-child relationship
        childVC.removeFromParent()
    }// end public func desembed child viewController
}// end default implementation of public protocol OSCAViewControllerContainable

