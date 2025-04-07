//
//  OSCAGeoPoint.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 14.02.22.
//


import Foundation
import CoreLocation


public struct OSCAGeoPoint: Hashable {
  public var latitude: Double
  public var longitude: Double
  
  public init( latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }// end public init
}// end struct OSCAGeoPoint

extension OSCAGeoPoint {
  /**
   [stackoverflow](https://stackoverflow.com/questions/33304340/how-to-find-out-distance-between-coordinates)
   [raywenderlich playground](https://github.com/raywenderlich/swift-algorithm-club/blob/master/HaversineDistance/HaversineDistance.playground/Contents.swift)
   [haversine formular](https://en.wikipedia.org/wiki/Haversine_formula)
   */
  private func haversineDinstance(la1: Double,    // latitude geopoint 1
                                  lo1: Double,    // longitude geopoint 1
                                  la2: Double,    // latitude geopoint 2
                                  lo2: Double,    // longitude geopoint 2
                                  radius: Double = 6367444.7 // Earth radius
  ) -> Double {
    
    let haversin = { (angle: Double) -> Double in
      return (1 - cos(angle))/2
    }// end let haversin
    
    let ahaversin = { (angle: Double) -> Double in
      return 2*asin(sqrt(angle))
    }// end let ahaversin
    
    // Converts from degrees to radians
    let dToR = { (angle: Double) -> Double in
      return (angle / 360) * 2 * .pi
    }// end let dToR
    
    let lat1 = dToR(la1)
    let lon1 = dToR(lo1)
    let lat2 = dToR(la2)
    let lon2 = dToR(lo2)
    
    return radius * ahaversin(haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1))
  }// end func haversineDinstance
  
  public func distanceInKilometers(to geoPoint: OSCAGeoPoint?) -> Double?{
    guard let distanceInMeters = distanceInMeters(to: geoPoint) else { return nil }
    return distanceInMeters/1000.0
  }// end public func distanceInKilometers
  
  public func distanceInMeters(to geoPoint: OSCAGeoPoint?) -> Double?{
    guard let geoPoint = geoPoint else {
      return nil
    }
    
    let dist = haversineDinstance(la1: self.latitude,
                                  lo1: self.longitude,
                                  la2: geoPoint.latitude,
                                  lo2: geoPoint.longitude)
    return dist
  }// end publi func distanceInMeters
}// end extension struct OSCAGeoPoint

// MARK: - Equatiable conformance
extension OSCAGeoPoint: Equatable {
  // swiftlint:disable operator_whitespace
  public static func ==(lhs: OSCAGeoPoint, rhs: OSCAGeoPoint) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
  }// end static func ==
  // swiftlint:enable operator_whitespace
}// end extension struct OSCAGeoPoint

// MARK: - distance between two OSCAGeoPoints
extension OSCAGeoPoint {
  private func distance(to geoPointStruct: OSCAGeoPoint) -> Int{
    let selfLocation = CLLocation(latitude: self.latitude,
                                  longitude: self.longitude)
    let toLocation   = CLLocation(latitude: geoPointStruct.latitude,
                                  longitude: geoPointStruct.longitude)
    let distance     = selfLocation.distance(from: toLocation)
    
    return roundToFive(distance)
  }// end func distance
  
  private func roundToFive(_ x : Double) -> Int {
    let precisionNumber = pow(10, Double(5))
    var n = x * precisionNumber
    n.round()
    n /= precisionNumber
    return Int(n)
  }// end func distance
}// end extension struct GeoPointStruct

// MARK: - initializer from CLLocation
extension OSCAGeoPoint {
  public init(_ clLocation: CLLocation) {
    self.longitude = clLocation.coordinate.longitude
    self.latitude  = clLocation.coordinate.latitude
  }// end public init from cl location
  
  public init(_ clLocationCoordinate2D: CLLocationCoordinate2D) {
    self.longitude = clLocationCoordinate2D.longitude
    self.latitude = clLocationCoordinate2D.latitude
  }// end public init form cl location coordinate 2D
  
  
  public init?(_ parseGeoPoint: ParseGeoPoint?) {
    guard let parseGeoPointNN  = parseGeoPoint,
          let parseGeoPointLat = parseGeoPointNN.latitude,
          let parseGeoPointLon = parseGeoPointNN.longitude
    else { return nil }
    self.latitude   = parseGeoPointLat
    self.longitude  = parseGeoPointLon
  }// end public init from parse geo point
}// end extension public struct OSCAGeoPoint

// MARK: - initializer from comma separated String
extension OSCAGeoPoint {
  public init?(_ geopointString: String) {
    let stringSplit = geopointString.split { $0 == "," }
    guard !stringSplit.isEmpty,
          stringSplit.count == 2,
          let latitude = Double(stringSplit[0]),
          let longitude = Double(stringSplit[1])
    else { return nil }
    self.latitude = latitude
    self.longitude = longitude
  }// end public init?
}// end extension public struct OSCAGeoPoint

// MARK: - codable conformance
extension OSCAGeoPoint: Codable {}// end extension OSCAGeoPoint

// MARK: - CLLocationCoordinate2D
extension OSCAGeoPoint {
  public var clLocationCoordinate2D: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
  }// end public var clLocationCoordinate2D
}// end extension public struct OSCAGeoPoint

extension OSCAGeoPoint {
  public var clLocation: CLLocation {
    return CLLocation(latitude: self.latitude, longitude: self.longitude)
  }// end public var clLocation
}// end extension public struct OSCAGeoPoint
