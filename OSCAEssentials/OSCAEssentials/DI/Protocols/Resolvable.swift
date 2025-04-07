//
//  Resolvable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 09.01.23.
//  based upon git@github.com:Tavernari/DIContainer.git
//  more information: https://medium.com/tribalscale/building-a-flexible-dependency-injection-library-for-swift-e92d68e02aec
//

import Foundation

public enum ResolveMode {
  case new
  case shared
}// end public enum ResolveMode

public protocol Resolvable {
  func resolve<DependencyType>(_ identifier: InjectIdentifier<DependencyType>,
                               mode: ResolveMode) throws -> DependencyType
}// end public protocol Resolvable

public enum ResolvableError: Error {
  case dependencyNotFound(Any.Type?, String?)
  case cast(Any.Type?)
}// end public enum ResolvableError

extension ResolvableError: LocalizedError {
  
  public var errorDescription: String? {
    switch self {
    case let .dependencyNotFound(type, key):
      var message = "Could not find dependency for "
      if let type = type {
        message += "type: \(type) "
      } else if let key = key {
        message += "key: \(key)"
      }// end if
      return message
      
    case let .cast(type):
      var message = "Could not cast dependency "
      if let type = type {
        message += "to type: \(type)"
      }
      return message
    }// end switch case
  }// end public var errorDescription
}// end extension enum ResolvableError
