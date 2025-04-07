//
//  StringTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 01.02.22.
//

import Foundation
import XCTest
@testable import OSCAEssentials

final class StringTests: XCTestCase {
    func testEmailIsValid() {
        let validEmailString = "example@domain.de"
        XCTAssertTrue(validEmailString.isValidEmail(), "The valid email string is tested invalid!")
        let invalidEmailString = "example@domain.d"
        XCTAssertFalse(invalidEmailString.isValidEmail(), "The invalid email string is tested valid!")
    }// end func testEmailIsValid
}// end final class StringTests
