//
//  Date+RegionTests.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 09.06.22.
//

import XCTest
@testable import OSCAEssentials
import Foundation
import SwiftDate

final class OSCAEssentialsDateRegionTests: XCTestCase {
  var essentialsTests: OSCAEssentialsTests?
  var module: OSCAEssentials?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    // init essentialsTest
    self.essentialsTests = OSCAEssentialsTests()
    XCTAssertNotNil(self.essentialsTests)
    XCTAssertNoThrow(try self.essentialsTests?.setUpWithError())
    // init module
    self.module = self.essentialsTests?.makeOSCAEssentials()
    XCTAssertNotNil(self.module)
  }// end override func setUpWithError
  
  func testLocalizedStringTomorrow() throws -> Void {
    // tomorrow
    let tomorrow: String = NSLocalizedString(
      "tomorrow",
      bundle: OSCAEssentials.bundle,
      comment: "Show text for tomorrow")
    XCTAssertNotNil(tomorrow)
  }// end func testLocalizedStringTomorrow
  
  func testLocalFormatTime() throws -> Void {
    // tomorrow
    let tomorrow: String = NSLocalizedString(
      "tomorrow",
      bundle: OSCAEssentials.bundle,
      comment: "Show text for tomorrow")
    // format string
    let formatString = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let expectedTodayFormatString = "HH:mm"
    let expectedTomorrowFormatString = "'\(tomorrow)' HH:mm"
    let expectedWeekFormatString = "dd.MM. HH:mm"
    
    // date now
    let dateNow = Date()
    let dateNowUTC = dateNow.convertTo(region: Region.UTC)
    let dateStringUTC = dateNowUTC.toFormat(formatString)
    // tested now string
    let testedDateString = (Date.dateFromISOString(string: dateStringUTC)).localFormatTime()
    // expected now string
    let expectedDateString = dateNow.toFormat(expectedTodayFormatString)
    XCTAssertEqual(testedDateString,
                   expectedDateString)
    // date tomorrow
    let dateTomorrow = dateNow + 1.days
    let dateTomorrowUTC = dateTomorrow.convertTo(region: Region.UTC)
    let dateTomorrowStringUTC = dateTomorrowUTC.toFormat(formatString)
    // tested tomorrow string
    let testedDateTomorrowString = (Date.dateFromISOString(string: dateTomorrowStringUTC)).localFormatTime()
    // expected tomorrow string
    let expectedDateTomorrowString = dateTomorrow.toFormat(expectedTomorrowFormatString)
    XCTAssertEqual(testedDateTomorrowString,
                   expectedDateTomorrowString)
    // date next week
    let dateWeek = dateNow + 1.weeks
    let dateWeekUTC = dateWeek.convertTo(region: Region.UTC)
    let dateWeekStringUTC = dateWeekUTC.toFormat(formatString)
    // tested week string
    let testedDateWeekString = (Date.dateFromISOString(string: dateWeekStringUTC)).localFormatTime()
    // expected tomorrow string
    let expectedDateWeekString = dateWeek.toFormat(expectedWeekFormatString)
    XCTAssertEqual(testedDateWeekString,
                   expectedDateWeekString)
    let nilDate: Date? = nil
    XCTAssertEqual(nilDate.localFormatTime(),
                   "---")
  }// end func testLocalFormatTime
}// end final class OSCAEssentialsDateRegionTests
