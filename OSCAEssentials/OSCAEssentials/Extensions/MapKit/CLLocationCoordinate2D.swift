//
//  CLLocationCoordinate2D.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 15.02.22.
//

import Foundation
import CoreLocation

public extension CLLocationCoordinate2D {
  init(from geoPoint: OSCAGeoPoint) {
    self.init(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
  }// init from geo point
}// end public extension struct CLLocationCoordinate2D

// Convert a KML coordinate list string to a C array of CLLocationCoordinate2Ds.
// KML coordinate lists are longitude,latitude[,altitude] tuples specified by whitespace.
public extension CLLocationCoordinate2D {
  static func strToCoords(_ str: String) -> [CLLocationCoordinate2D] {
    var coords: [CLLocationCoordinate2D] = []
    coords.reserveCapacity(10)
    
    let tuples = str.components(separatedBy: CharacterSet.whitespacesAndNewlines)
    for tuple in tuples {
      let scanner = Scanner(string: tuple)
      scanner.charactersToBeSkipped = CharacterSet(charactersIn: ",")

      if let lonDouble = scanner.scanDouble(),
         let latDouble = scanner.scanDouble()
      {
        let coordinate = CLLocationCoordinate2DMake(latDouble, lonDouble)
        if CLLocationCoordinate2DIsValid(coordinate) {
          coords.append(coordinate)
        }
      }
    }
    
    return coords
  }
}
