//
//  ParseDate.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.01.23.
//

import Foundation

// MARK: - JSONProtocol conformance
extension ParseDate: JSONProtocol {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
    case .parseDate(let parseDate):
      self.init(parseDate)
    default:
      return nil
    }// end switch case
  }// end init
}// end extension ParseDate
