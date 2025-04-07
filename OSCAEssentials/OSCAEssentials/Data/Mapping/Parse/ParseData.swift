//
//  ParseData.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 09.02.22.
//

import Foundation

// MARK: - ParseData
public struct ParseData: Codable, Hashable {
    public let type: String?
    public let className: String?
    public let objectID: String?

    private enum CodingKeys: String, CodingKey {
        case type = "__type"
        case className
        case objectID = "objectId"
    }// end enum CodiingKeys
}// end public struct ParseData

// MARK: - ParseData Equatable conformance
extension ParseData: Equatable {
  // swiftlint: disable operator_whitespace
    public static func ==(lhs:ParseData, rhs:ParseData) -> Bool{
        let typeEquals: Bool = lhs.type == rhs.type
        let classNameEquals: Bool = lhs.className == rhs.className
        let objectIDEquals: Bool = lhs.objectID == rhs.objectID
        return typeEquals &&
               classNameEquals &&
               objectIDEquals
    }// end public static func ==
  // swiftlint: enable operator_whitespace
}// end extension struct ParseData: Equatable

// MARK: ParseData convenience initializers and mutators
extension ParseData {
    public init(data: Data) throws {
        self = try OSCAParse.newJSONDecoder().decode(ParseData.self, from: data)
    }// end init data

    public init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }// end init json

    public init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }// end init url

    public func with(
        type: String? = nil,
        className: String? = nil,
        objectID: String? = nil
    ) -> ParseData {
        return ParseData(
            type: type ?? self.type,
            className: className ?? self.className,
            objectID: objectID ?? self.objectID
        )// end return
    }// end func with

    public func jsonData() throws -> Data {
        return try OSCAParse.newJSONEncoder().encode(self)
    }// end func jsonData

    public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }// end func jsonString
}// end extension struct ParseData
