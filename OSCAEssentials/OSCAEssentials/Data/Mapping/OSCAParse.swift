//
//  Parse.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 09.02.22.
//

import Foundation

public enum OSCAParse {
    /// [see](https://stackoverflow.com/a/68101019)
    /// [also](https://stackoverflow.com/a/69982966)
    @propertyWrapper
    public struct BoolFromString: Codable, Hashable, Equatable {
        public let wrappedValue: Bool?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let stringValue = try container.decode(String.self)
            switch stringValue.lowercased() {
            case "true", "yes", "1":
                self.wrappedValue = true
            case "false", "no", "0":
                self.wrappedValue = false
            default: throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected `true, yes, 1`or `false, no, 0` but received `\(stringValue)`")
            }// end switch case
        }// end init from decoder throws
        
        public init(value: Bool) {
            self.wrappedValue = value
        }// end public init
    }// end struct BoolFromString
    
    /// [see](https://stackoverflow.com/a/68101019)
    /// [also](https://stackoverflow.com/a/69982966)
    /// [coding praxis for finite values like Bool](https://www.wyzant.com/resources/answers/613992/swift-good-coding-practice-if-statement-with-optional-type-bool)
    @propertyWrapper
    public struct BoolFromDict: Codable, Hashable, Equatable {
        public var wrappedValue: Bool
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            var boolValue: Bool = true
            do {
                boolValue = try container.decode(Bool.self)
            } catch {
                boolValue = false
            }// end do
            switch boolValue {
            case true:
                self.wrappedValue = true
            case false:
                self.wrappedValue = false
            }// end switch case
        }// end init from decoder throws
        
        public init(wrappedValue: Bool) {
            self.wrappedValue = wrappedValue
        }// end public init
    }// end struct BoolFromDict
    
 
    
    // MARK: - Helper functions for creating encoders and decoders
    public static func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }// end public func newJSONDecoder

    public static func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }// end public func newJSONEncoder
    
    /// generic mutatiing function  for reducing the amount of elements conforming to `OSCAParseClassObject` to `limit`
    /// - Parameter limit: amount value to which to reduce the list
    /// - Parameter list: list of elements conforming to `OSCAParseClassObject`, `inout`
    public static func reduce<T: OSCAParseClassObject>(to limit: Int, in list: inout [T]) -> Void {
        list = list.count <= limit ? list : Array(list[0..<limit])
    }// end public static func reduceAllEvents
    
    /// generic mutating function for filtering a list of elements conforming to `OSCAParseClassObject` by `predicate`closure
    /// - Parameter in list: list of elements conforming to `OSCAParseClassObject`, `inout`
    /// - Parameter by predicate: filter by predicate closure
    public static func filter<T: OSCAParseClassObject>(in list: inout[T], by predicate: (T) -> Bool) -> Void {
        guard !list.isEmpty else { return }
        
        list = list.filter(predicate)
    }// end public static func filter list by predicate

    /// generic mutating function for filtering a list of elements conforming to `OSCAParseClassObject`, that contains `string`
    /// - Parameter for string: search string separated by blanks
    /// - Parameter in list: list of elements conforming to `OSCAParseClassObject` (`inout`)
    public static func filter<T: OSCAParseClassObject>(for string: String, in list: inout[T]) -> Void {
        let searchArray: [String] = string.lowercased().components(separatedBy: " ")
        var exp = ""
        for key in searchArray {
            if searchArray.firstIndex(of: key) == 0 {
                exp = "self CONTAINS '\(key)'"
            } else {
                exp += " and self CONTAINS '\(key)'"
            }
        }// end for key
        let predicate = NSPredicate(format: exp)
        
        list = list.filter({ predicate.evaluate(with: $0) })
    }// end private func filter for string in list
    
    /// generic mutating function for sorting a list of elements comforming to `OSCAParseClassObject`by `strategy` closure
    /// - Parameter list: list of elements conforming to `OSCAParseClassObject` (`inout`)
    /// - Parameter by strategy: strategy closure
    public static func sort<T: OSCAParseClassObject>(list: inout [T], by strategy: (T, T) -> Bool) -> Void {
        list = list.sorted(by: strategy)
    }// end public static func sort list by strategy
}// end public struct Parse
