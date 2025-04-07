//
//  OSCAConfig.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 06.02.23.
//

import Foundation

public enum OSCAConfig {
  case production
  case develop
  case mock
}// end public enum OSCAConfig

@propertyWrapper
public struct DIConfigure {
  public init?(config: OSCAConfig) {
    wrappedValue = try? DIContainer.container(for: config)
  }// end public init
  private(set) public var wrappedValue: DIContainer?
}// end @propertyWrapper public struct Configured
