//
//  Optional+JSON.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.01.23.
//

import Foundation

// MARK: - JSONProtocol conformance
extension Optional: JSONProtocol where Wrapped == JSON {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
    case .null:
      self = .null
    default:
      return nil
    }// end switch case
  }// end public init
}// end extension Optional where Wrapped == JSON
