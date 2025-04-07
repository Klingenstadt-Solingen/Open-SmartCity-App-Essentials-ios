//
//  UIImage+PlaceholderTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 04.04.22.
//

import Foundation
import XCTest
@testable import OSCAEssentials

final class UIImagePlaceholderTests: XCTestCase {
    func testPlaceholder() {
        let placeholder = UIImage.placeholder
        XCTAssertNotNil(placeholder)
    }// end func testPlaceholder
}// end final class UIImage+PlaceholderTests
