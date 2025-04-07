//
//  OSCAEssentialsDateStringTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 07.06.22
//

import XCTest
@testable import OSCAEssentials
import Foundation

final class OSCAEssentialsDateStringTests: XCTestCase {
  func testToDate() {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "dd.MM.yyyy"
    
    let date = dateformatter.date(from: "01.01.2022")
    let dateString = date?.toString
    
    XCTAssertEqual(dateString, "01.01.22")
  }// end func testToDate
  
  func testISOStringFromDate() -> Void {
    let date = Date(timeIntervalSince1970: 1654614358)
    let isoString = Date.ISOStringFromDate(date: date)
    XCTAssertEqual(isoString, "2022-06-07T15:05:58.000Z")
  }// end func testISOStringFromDate
  
  func testDateFromISOString() -> Void {
    let isoString = "2022-06-07T15:05:58.000Z"
    let dateFromISOString = Date.dateFromISOString(string:isoString)
    let date = Date(timeIntervalSince1970: 1654614358)
    XCTAssertEqual(dateFromISOString, date)
    let dateFromISOStringWithTimeZone = Date.dateFromISOString(string: isoString)
    XCTAssertNotNil(dateFromISOStringWithTimeZone)
  }// end func testDateFromIsoString
  
  func testTimeIntervalSinceNow() -> Void {
    let dateNow = Date()
    let isoString = Date.ISOStringFromDate(date: dateNow)
    let dateFromISO = Date.dateFromISOString(string: isoString)
    XCTAssertNotNil(dateFromISO)
    let interval = dateFromISO!.timeIntervalSinceNow
    XCTAssertTrue(interval <= 0)
  }// end func testTimeIntervalSinceNow

}// end final class OSCAEssentailsDateStringTest
