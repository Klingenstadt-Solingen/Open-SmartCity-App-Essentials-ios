//
//  InjectIdentifier.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 23.12.22.
//  based upon git@github.com:Tavernari/DIContainer.git
//

import Foundation

public struct InjectIdentifier<DependencyType> {
  
  private(set) var type: DependencyType.Type?
  private(set) var key: String?
  
  private init(type: DependencyType.Type? = nil, key: String? = nil) {
    self.type = type
    self.key = key
  }// end private init
}// end public struct InjectIdentifier

// MARK: - Hashable conformance
extension InjectIdentifier: Hashable {
  public static func == (lhs: InjectIdentifier, rhs: InjectIdentifier) -> Bool {
    lhs.hashValue == rhs.hashValue
  }// end public static func ==
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(DependencyType.self))
    // hasher.combine(self.key)
    if let key = self.key {
      hasher.combine(key)
    }
    if let type = self.type {
      hasher.combine(ObjectIdentifier(type))
    }// end if
  }// end public func hash
}// end extension struct InjectIdentifier

public extension InjectIdentifier {
  static func by(type: DependencyType.Type? = nil,
                 key: String? = nil) -> InjectIdentifier {
    let identifier = InjectIdentifier(type: type,
                           key: key)
    return identifier
  }// end static func by type key
}// end public extension struct InjectIdentifier
