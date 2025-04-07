//
//  DateMillisTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 01.03.22.
//

import Foundation

import XCTest
@testable import OSCAEssentials

final class DateMillisTests: XCTestCase {
    func testDateMillis() {
        let today = Date()
        let testToday = Date(milliseconds: today.millisecondsSince1970)
        XCTAssertEqual(today.millisecondsSince1970, testToday.millisecondsSince1970)
    }// end func testDateMillis
}// end final class DateMillisTests
