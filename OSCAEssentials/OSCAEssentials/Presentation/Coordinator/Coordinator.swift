//
//  Coordinator.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 10.11.21.
//
import Foundation

public protocol Coordinator: AnyObject {

  var children: [Coordinator] { get set }
  var router: Router { get }

  func present(animated: Bool, onDismissed: (() -> Void)?)
  func dismiss(animated: Bool)
  func presentChild(_ child: Coordinator,
                    animated: Bool,
                    onDismissed: (() -> Void)?)
}// end public protocol Coordinator

extension Coordinator {

  public func dismiss(animated: Bool) {
    router.dismiss(animated: animated)
  }// end public func dismiss

  public func presentChild(_ child: Coordinator,
                           animated: Bool,
                           onDismissed: (() -> Void)? = nil) {
    children.append(child)
    child.present(animated: animated, onDismissed: { [weak self, weak child] in
      guard let self = self, let child = child else { return }
      self.removeChild(child)
      onDismissed?()
    })
  }// end public func presentChild

  private func removeChild(_ child: Coordinator) {
    guard let index = children.firstIndex(where:  { $0 === child })
      else {
        return
    }
    children.remove(at: index)
  }// end private func removeChild
}// end extension public protocol Coordinator

