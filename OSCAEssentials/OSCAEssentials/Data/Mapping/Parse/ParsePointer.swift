//
//  ParsePointer.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 14.06.22.
//

import Foundation
/// ```json
/// {
///     "__type":"Pointer",
///     "className":"_User",
///     "objectId":"dCXzj8OShZ"
/// }
/// ```
public struct ParsePointer {
  public var type: String?
  public var className: String?
  public var objectId: String?
  
  private enum CodingKeys: String, CodingKey {
    case type = "__type"
    case className
    case objectId
  }// end private enum CodingKeys
  
  public init(type: String? = "Pointer",
              className: String? = nil,
              objectId: String? = nil) {
    self.type = type
    self.className = className
    self.objectId = objectId
  }// end public init
}// end public struct ParsePointer

extension ParsePointer: Decodable {
  public init(from decoder: Decoder) throws {
    var container = try decoder.container(keyedBy: ParsePointer.CodingKeys.self)
    self.type = try container.decode(String.self, forKey: .type)
    self.className = try container.decode(String.self, forKey: .className)
    self.objectId = try container.decode(String.self, forKey: .objectId)
  }// end public init from decoder
}// end extension public struct ParsePointer

extension ParsePointer: Encodable{}

extension ParsePointer: Equatable{}

extension ParsePointer: Hashable{}

extension ParsePointer {
  public init(_ value: ParsePointer) {
    self.init(type: value.type,
              className: value.className,
              objectId: value.objectId)
  }// end copy constructor
}// end extension public struct ParsePointer

