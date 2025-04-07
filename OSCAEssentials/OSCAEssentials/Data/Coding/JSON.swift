//
//  JSON.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 24.01.23.
//

import Foundation

// MARK: JSONProtocol
public protocol JSONProtocol {
  init?(_ value: JSON?)
}// end public protocol JSONProtocol

// MARK: JSON
/// [based upon](https://stackoverflow.com/a/58175981)
public enum JSON {
  case parseDate(ParseDate)
  case parsePointer(ParsePointer)
  case string(String)
  case integer(Int)
  case double(Double)
  case object([JSON.Key: JSON])
  case array([JSON])
  case bool(Bool)
  case null
  
  public init(from decoder: Decoder) throws {
    // ParseDate?
    if let parseDate = try? ParseDate(from: decoder) { self = .parseDate(parseDate) }
    // ParsePointer?
    else if let parsePointer = try? ParsePointer(from: decoder) { self = .parsePointer(parsePointer) }
    // Integer?
    else if let integer = try? Int(from: decoder) { self = .integer(integer) }
    // Double?
    else if let double = try? Double(from: decoder) { self = .double(double) }
    // Object?
    else if let object = try? decoder.container(keyedBy: JSON.Key.self) {
      var result: [JSON.Key: JSON] = [:]
      for key in object.allKeys {
        result[key] = (try? object.decode(JSON.self, forKey: key)) ?? .null
      }// end for key in all keys
      self = .object(result)
    }// end if
    // Array?
    else if var array = try? decoder.unkeyedContainer() {
      var result: [JSON] = []
      for _ in 0..<(array.count ?? 0) {
        result.append(try array.decode(JSON.self))
      }// end for
      self = .array(result)
    }// end if
    // Bool?
    else if let bool = try? decoder.singleValueContainer().decode(Bool.self) { self = .bool(bool) }
    // Null?
    else if let isNull = try? decoder.singleValueContainer().decodeNil(),
            isNull { self = .null }
    // String?
    else if let string = try? decoder.singleValueContainer().decode(String.self) { self = .string(string) }
    // throw error
    else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [],
                                                                   debugDescription: "Unknown JSON type")) }
  }// end init from decoder
  
  public func encode(to encoder: Encoder) throws {
    switch self {
      // ParseDate
    case .parseDate(let parseDate):
      var container = encoder.singleValueContainer()
      try container.encode(parseDate)
      // ParsePointer
    case .parsePointer(let parsePointer):
      var container = encoder.singleValueContainer()
      try container.encode(parsePointer)
      // String
    case .string(let string):
      var container = encoder.singleValueContainer()
      try container.encode(string)
      // Int
    case .integer(let integer):
      var container = encoder.singleValueContainer()
      try container.encode(integer)
      // Double
    case .double(let double):
      var container = encoder.singleValueContainer()
      try container.encode(double)
      // Object
    case .object(let object):
      var container = encoder.container(keyedBy: JSON.Key.self)
      for (key, value) in object {
        try container.encode(value, forKey: key)
      }// end for key, value in object
      // Array
    case .array(let array):
      var container = encoder.unkeyedContainer()
      for value in array {
        try container.encode(value)
      }// end for value in array
      // Bool
    case .bool(let bool):
      var container = encoder.singleValueContainer()
      try container.encode(bool)
      // Null
    case .null:
      var container = encoder.singleValueContainer()
      try container.encodeNil()
    }// end switch case
  }// end func encode to encoder
  
}// end public enum JSON

// - MARK: JSON subscript
extension JSON {
  /// `Computed read only subscript`
  ///
  /// usage: ```object["ExampleKey"]```
  public subscript<T>(key: String) -> T? where T: JSONProtocol {
    switch self {
    case .object(let object):
      let jsonKey = JSON.Key[key]
      if object.keys.contains(where: { jsonKey == $0 }) {
        let value = object[jsonKey]
        return T.init(value)
      } else {
        return nil
      }// end if
    default:
      return nil
    }// end switch case
  }// end public subscript
}// end extension public enum JSON

// - MARK: JSON.Key
extension JSON {
  public struct Key {
    public var description: String { return stringValue }
    public let stringValue: String
    public init(_ string: String) { self.stringValue = string }
    public init?(stringValue: String) { self.init(stringValue) }
    public var intValue: Int? { return nil }
    public init?(intValue: Int) { return nil }
    /// `Type subscript` on `JSON.Key`
    ///
    /// usage: ``` JSON.Key["ExampleString"] ```
    public static subscript(key: String) -> JSON.Key {
      let jsonKey = JSON.Key(stringValue: key)!
      return jsonKey
    }// end public static subscript
  }// end struct Key
}// end extension public enum JSON

extension JSON: Codable {}
extension JSON: Hashable {}
extension JSON: Equatable {}
extension JSON.Key: CodingKey {}
extension JSON.Key: Hashable {}
extension JSON.Key: CustomStringConvertible {}
extension JSON.Key: Equatable {}

// MARK: - JSONProtocol conformance
extension JSON: JSONProtocol {
  public init?(_ value: JSON?) {
    guard let value = value else { return nil }
    switch value {
      // ParseDate
    case .parseDate(let parseDate):
      self = .parseDate(parseDate)
      // ParsePointer
    case .parsePointer(let parsePointer):
      self = .parsePointer(parsePointer)
      // Int
    case .integer(let integer):
      self = .integer(integer)
      // Double
    case .double(let double):
      self = .double(double)
      // Object
    case .object(let object):
      self = .object(object)
      // Array
    case .array(let array):
      self = .array(array)
      // Bool
    case .bool(let bool):
      self = .bool(bool)
      // Null
    case .null:
      self = .null
      // String
    case .string(let string):
      self = .string(string)
    }// end switch case
  }// end public init copy constructor
}// end extension JSON

extension JSON {
  var parseDate: ParseDate? {
    switch self {
    case .parseDate(let parseDate):
      return parseDate
    default:
      return nil
    }// end switch case
  }// end public var parseDate
  
  var parsePointer: ParsePointer? {
    switch self {
    case .parsePointer(let parsePointer):
      return parsePointer
    default:
      return nil
    }// end switch case
  }// end public var parsePointer
  
  var string: String? {
    switch self {
    case .string(let string):
      return string
    default:
      return nil
    }// end switch case
  }// end public var string
  
  var integer: Int? {
    switch self {
    case .integer(let integer):
      return integer
    default:
      return nil
    }// end switch case
  }// end public var integer
  
  var double: Double? {
    switch self {
    case .double(let double):
      return double
    default:
      return nil
    }// end switch case
  }// end public var double
  
  var object: [JSON.Key: JSON]? {
    switch self {
    case .object(let object):
      return object
    default:
      return nil
    }// end switch case
  }// end public var object
  
  var array: [JSON]? {
    switch self {
    case .array(let array):
      return array
    default:
      return nil
    }// end switch case
  }// end public var array
  
  var bool: Bool? {
    switch self {
    case .bool(let boolValue):
      return boolValue
    default:
      return nil
    }// end switch case
  }// end public var bool
  
  var null: JSON? {
    switch self {
    case .null:
      return nil
    default:
      return nil
    }// end switch case
  }// end public var null
}// end extension public enum JSON

extension JSON.Key: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }// end public init
}// end extension public struct JSON.Key

