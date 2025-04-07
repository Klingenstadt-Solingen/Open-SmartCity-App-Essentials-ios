//
//  DeeplinkHandler.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 13.07.22.
//

import Foundation

open class DeeplinkHandler: OSCADeeplinkHandeble {
  public struct Dependencies {
    let deeplinkURL: String
    
    public init(deeplinkURL: String) {
      self.deeplinkURL = deeplinkURL
    }// end public init deeplinkURL
  }// end DeeplinkHandler.Dependencies
  
  let dependencies: DeeplinkHandler.Dependencies
  
  public func canOpenURL(_ url: URL) -> Bool {
    return url.absoluteString == dependencies.deeplinkURL
  }// end func canOpenURL
  
 func getQueryItems(from url: URL) -> [URLQueryItem]? {
    guard canOpenURL(url) else { return nil }
    let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    guard let queryItems = urlComponents?.queryItems
    else { return [] }
    return queryItems
  }// end private func get query Items from URL
  
  func getItems(from url: URL) -> [String:String]? {
    guard let queryItems = getQueryItems(from: url) else { return nil }
    var items: [String:String] = [:]
    items = queryItems.reduce(into: [:]) { dictionary, item in
      dictionary[item.name] = item.value?.removingPercentEncoding
    }// end reduce
    return items
  }// end private func get items from URL
  
  open func openURL(_ url: URL,
                    onDismissed: (() -> Void)?) throws -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    guard canOpenURL(url)
    else { throw DeeplinkHandler.Error.cannotOpenDeeplink(urlString: url.absoluteString) }
  }// end func open URL
  
  public init(dependencies: DeeplinkHandler.Dependencies) {
    self.dependencies = dependencies
  }// end init
}// end final class DeeplinkHandler
