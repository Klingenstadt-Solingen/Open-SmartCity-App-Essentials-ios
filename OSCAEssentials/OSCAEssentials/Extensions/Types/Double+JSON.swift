//
//  Double+JSON.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.01.23.
//

import Foundation

// MARK: - JSONProtocol conformance
extension Double: JSONProtocol {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
    case .double(let double):
      self.init(double)
    default:
      return nil
    }// end switch case
  }// end init
}// end extension Double
