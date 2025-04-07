//
//  OSCAParseClassObject.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 24.02.22.
//

import Foundation

/// bare minimum protocol of an object class of the Parse mBaaS
public protocol OSCAParseClassObject: Codable, Hashable, Equatable {
  /// auto generated id
  var objectId      : String?   { get }
  /// UTC date when the object was created
  var createdAt     : Date?     { get }
  /// UTC date when the object was changed
  var updatedAt     : Date?     { get }
  /// Parse class name
  static var parseClassName: String   { get }
}// end public protocol OSCAParseClassObject
