//
//  Bool+JSON.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.01.23.
//

import Foundation

// MARK: - JSONProtocol conformance
extension Bool: JSONProtocol {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
    case .bool(let bool):
      self.init(bool)
    default:
      return nil
    }// end switch case
  }// end init
}// end public extension Bool
