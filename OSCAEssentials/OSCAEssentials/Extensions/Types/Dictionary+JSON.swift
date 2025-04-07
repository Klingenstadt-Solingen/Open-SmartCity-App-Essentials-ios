//
//  Dictionary+JSON.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.01.23.
//

import Foundation

// MARK: - JSONProtocol conformance
extension Dictionary: JSONProtocol where Key == JSON.Key, Value == JSON {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
    case .object(let object):
      self = object
    default:
      return nil
    }// end switch case
  }// end init
}// end extension Dictionary where Keyy == JSON.Key, Value == JSON
