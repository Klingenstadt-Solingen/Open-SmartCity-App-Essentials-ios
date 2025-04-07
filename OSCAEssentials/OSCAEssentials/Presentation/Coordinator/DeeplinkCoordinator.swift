//
//  DeeplinkCoordinator.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 13.07.22.
//

import Foundation

public protocol DeeplinkCoordinateble {
  var handler: [OSCADeeplinkHandeble] { get }
  
  @discardableResult
  func handleURL(_ url: URL,
                 onDismissed: (() -> Void)?) -> Bool
}// end public protocol DeeplinkCoordinateble

// MARK: - default implementation of handleURL
extension DeeplinkCoordinateble {
  @discardableResult
  public func handleURL(_ url: URL,
                        onDismissed: (() -> Void)?) -> Bool{
    guard let handler = handler.first(where: { $0.canOpenURL(url) }) else {
      return false
    }
    do {
      try handler.openURL(url,
                          onDismissed: onDismissed)
    } catch {
      return false
    }// end do try
    return true
  }// end func handle url
}// end public extension

// MARK: - example implementation
/// [see deeplinking](https://benoitpasquier.com/deep-linking-url-scheme-ios/)
public final class DeeplinkCoordinator {
  public var handler: [OSCADeeplinkHandeble]

  public init(handlers: [OSCADeeplinkHandeble]) {
    self.handler = handlers
  }// end init
}// end final class DeeplinkCoordinator

// MARK: - DeeplinkCoordinateble conformance
extension DeeplinkCoordinator: DeeplinkCoordinateble {}// end extension public final class DeeplinkCoordinator
