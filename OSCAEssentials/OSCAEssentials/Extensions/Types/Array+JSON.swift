//
//  Array+JSON.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.01.23.
//

import Foundation

// MARK: - JSONProtocol conformance
extension Array: JSONProtocol where Element == JSON {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
    case .array(let array):
      self = array
    default:
      return nil
    }// end switch case
  }// end public init
}// end extension Array where Element == JSON
