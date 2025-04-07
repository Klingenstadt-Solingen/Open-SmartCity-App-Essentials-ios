//
//  ParsePointer.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.01.23.
//

import Foundation

// MARK: - JSONProtocol conformance
extension ParsePointer: JSONProtocol {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
    case .parsePointer(let parsePointer):
      self.init(parsePointer)
    default:
      return nil
    }// end switch case
  }// end init
}// end public extension ParsePointer
