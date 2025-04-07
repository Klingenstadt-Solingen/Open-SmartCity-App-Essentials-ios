//
//  OSCAGeoPointTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 14.02.22.
//

import Foundation
import XCTest
@testable import OSCAEssentials

final class OSCAGeoPointTests: XCTestCase {
    var amsterdam: OSCAGeoPoint!
    var newYork: OSCAGeoPoint!
    var distAmsterdamToNewYourKM: Double!
    
    override func setUp() {
        super.setUp()
        self.amsterdam = OSCAGeoPoint(latitude: 52.3702, longitude: 4.8952)
        self.newYork = OSCAGeoPoint(latitude: 40.7128, longitude:  -74.0059)
        self.distAmsterdamToNewYourKM = 5859.270905561898
    }// end override func setUp
    
    func testDistanceInKilometers() {
        let distKMAmsterdamToNewYork = self.amsterdam.distanceInKilometers(to: self.newYork)
        let distKMNewYorkToAmsterdam = self.newYork.distanceInKilometers(to: self.amsterdam)
        XCTAssertEqual(distKMAmsterdamToNewYork, distKMNewYorkToAmsterdam)
        XCTAssertEqual(distKMAmsterdamToNewYork, self.distAmsterdamToNewYourKM)
        XCTAssertEqual(distKMNewYorkToAmsterdam, self.distAmsterdamToNewYourKM)
        /*
        // Google says it's 5857 km so our result is only off by 2km which could be due to all kinds of things, not sure how google calculates the distance or which latitude and longitude google uses to calculate the distance.
        haversineDinstance(la1: amsterdam.0, lo1: amsterdam.1, la2: newYork.0, lo2: newYork.1)
         */
    }// end func testDistanceInKilometers
    
    func testDistanceInKilometersNil() {
        let distKMAmsterdamToNil = self.amsterdam.distanceInKilometers(to: nil)
        let distKMNewYorkToNil = self.newYork.distanceInKilometers(to: nil)
        XCTAssertEqual(distKMAmsterdamToNil, distKMNewYorkToNil)
        XCTAssertNil(distKMAmsterdamToNil)
        XCTAssertNil(distKMNewYorkToNil)
    }// end func testDistanceInKilometersNil
    
    func testDistanceInMeters() {
        let distMAmsterdamToNewYork = self.amsterdam.distanceInMeters(to: self.newYork)
        let distMNewYorkToAmsterdam = self.newYork.distanceInMeters(to: self.amsterdam)
        XCTAssertEqual(distMAmsterdamToNewYork, distMNewYorkToAmsterdam)
        XCTAssertEqual(distMAmsterdamToNewYork, self.distAmsterdamToNewYourKM * 1000)
        XCTAssertEqual(distMNewYorkToAmsterdam, self.distAmsterdamToNewYourKM * 1000)
    }// end fnc testDistanceInMeters
    
    func testDistanceInMetersNil() {
        let distMAmsterdamToNil = self.amsterdam.distanceInMeters(to: nil)
        let distMNewYorkToNil = self.newYork.distanceInMeters(to: nil)
        XCTAssertEqual(distMAmsterdamToNil, distMNewYorkToNil)
        XCTAssertNil(distMAmsterdamToNil)
        XCTAssertNil(distMNewYorkToNil)
    }// end testDistanceInMetersNil
}// end final class OSCAGeoPointTest
