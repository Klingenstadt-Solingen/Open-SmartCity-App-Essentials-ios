//
//  Entity.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 04.10.21.
//
import Foundation
public protocol Entity: Equatable {
    typealias Identifier = String
    
    typealias GeoPoint = OSCAGeoPoint
    
    
    /**
          read only identifier
     */
    var id: Identifier { get }// end id
    
}// end protocol Entity

/**
 named Tuple
 - latitude : floating point value double precision
 - longitude: floating point value double precision
 [about Tuple in Swift](https://www.hackingwithswift.com/example-code/language/what-is-a-tuple)
 */
public typealias GeoPointTuple = (latitude: Double, longitude: Double)




