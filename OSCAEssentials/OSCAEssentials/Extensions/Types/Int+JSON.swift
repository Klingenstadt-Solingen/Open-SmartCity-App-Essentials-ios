//
//  Int+JSON.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.01.23.
//

import Foundation

// MARK: - JSONProtocol conformance
extension Int: JSONProtocol {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
    case .integer(let integer):
      self.init(integer)
    default:
      return nil
    }// end switch case
  }// end init
}// end extension Int
