//
//  String+JSON.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.01.23.
//

import Foundation

// MARK: - JSONProtocol conformance
extension String: JSONProtocol {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
    case .string(let string):
      self.init(string)
    default:
      return nil
    }// end switch case
  }// end init
}// end public extension String
