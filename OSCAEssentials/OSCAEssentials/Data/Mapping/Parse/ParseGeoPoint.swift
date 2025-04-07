//
//  ParseGeoPoint.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 09.02.22.
//

import Foundation


// MARK: - ParseGeoPoint
public struct ParseGeoPoint: Codable, Hashable {
  public let type: String?
  public var latitude: Double?
  public let longitude: Double?
  
  private enum CodingKeys: String, CodingKey {
    case type = "__type"
    case latitude
    case longitude
  }// end private enum CodingKeys
}// end public struct Geopoint

// MARK: - ParseGeoPoint Equatable conformance
extension ParseGeoPoint: Equatable {
  public static func ==(lhs:ParseGeoPoint, rhs:ParseGeoPoint) -> Bool{
    let typeEquals: Bool = lhs.type == rhs.type
    let latitudeEquals: Bool = lhs.latitude == rhs.latitude
    let longitudeEquals: Bool = lhs.longitude == rhs.longitude
    return typeEquals &&
    latitudeEquals &&
    longitudeEquals
  }// end public static func ==
}// end extension struct ParseGeoPoint: Equatable

// MARK: ParseGeoPoint convenience initializers and mutators
extension ParseGeoPoint {
  public init(latitude: Double? = nil, longitude: Double? = nil) {
    if let latNN: Double = latitude,
       let lonNN: Double = longitude {
      self.latitude = latNN
      self.longitude = lonNN
    } else {
      self.latitude = ParseGeoPoint.defaultGeoTouple.latitude
      self.longitude = ParseGeoPoint.defaultGeoTouple.longitude
    }// end if
    self.type = "GeoPoint"
  }// end public init with lat lon
  
  public init(data: Data) throws {
    self = try OSCAParse.newJSONDecoder().decode(ParseGeoPoint.self, from: data)
  }// end init data
  
  public init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }// end int json
  
  public init(fromURL url: URL) throws {
    try self.init(data: try Data(contentsOf: url))
  }// end init url
  
  public func with( type: String? = nil,
                    latitude: Double? = nil,
                    longitude: Double? = nil
  ) -> ParseGeoPoint {
    return ParseGeoPoint(type: type ?? self.type,
                         latitude: latitude ?? self.latitude,
                         longitude: longitude ?? self.longitude
    )// end return
  }// end func with
  
  public func jsonData() throws -> Data {
    return try OSCAParse.newJSONEncoder().encode(self)
  }// end func jsonData
  
  public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }// end public jsonString
}// end extension ParseGeoPoint

// MARK: default geo location as struct
extension ParseGeoPoint {
  public static var defaultGeoStruct: OSCAGeoPoint {
    return .init( latitude: Environment.defaultGeoPoint.latitude,
                  longitude: Environment.defaultGeoPoint.longitude)
  }// end public static var defaultGeoStruct
}// end extension struct ParseGeoPoint default location struct

// MARK: ParseGeoPoint default geo location touple
extension ParseGeoPoint {
  public static var defaultGeoTouple: (latitude: Double, longitude: Double) {
    return ( latitude: Environment.defaultGeoPoint.latitude,
             longitude: Environment.defaultGeoPoint.longitude)
  }// end public var defaultGeoTouple
}// end extension struct ParseGeoPoint default location tuple

// MARK: ParseGeoPoint geopoint as touple
extension ParseGeoPoint {
  public var touple: (latitude: Double, longitude: Double) {
    if let latNN: Double = self.latitude,
       let lonNN: Double = self.longitude {
      return (latitude: latNN,
              longitude: lonNN)
    } else {
      return ParseGeoPoint.defaultGeoTouple
    }// end if
  }// end public var touple
}// end extension struct ParseGeoPoint

// MARK: ParseGeoPoint geopoint as struct OSCAGeoPoint
extension ParseGeoPoint {
  public var geoPointStruct: OSCAGeoPoint {
    if let latNN: Double = self.latitude,
       let lonNN: Double = self.longitude {
      return OSCAGeoPoint( latitude: latNN,
                           longitude: lonNN )
    } else {
      return ParseGeoPoint.defaultGeoStruct
    }// end if
  }// end public var geoPointStruct
}// end extension struct ParseGeoPoint

