//
//  DeeplinkError.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 25.08.22.
//

import Foundation

extension DeeplinkHandler {
  public enum Error {
    case malformedURLString(urlString: String)
    case cannotOpenDeeplink(urlString: String)
    case deeplinkHandlerInitFail
    case queryItemsMissing(urlString: String)
  }// end public enum Error
}// end extension public class DeeplinkHandler

extension DeeplinkHandler.Error: Swift.Error {}

extension DeeplinkHandler.Error: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .malformedURLString(urlString):
      return "The deeplink's URL is malformed: \(urlString)."
    case let .cannotOpenDeeplink(urlString):
      return "Cannot open deeplink: \(urlString)."
    case .deeplinkHandlerInitFail:
      return "Cannot init deeplink handler."
    case let .queryItemsMissing(urlString):
      return "There are no query items in deeplink: \(urlString)"
    }// end switch case
  }// end public var description
}// end extension public enum Deeplinkhandler.Error


