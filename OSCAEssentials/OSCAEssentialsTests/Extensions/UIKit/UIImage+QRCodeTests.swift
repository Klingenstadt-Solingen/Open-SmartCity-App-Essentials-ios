//
//  UIImage+QRCodeTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 30.01.23.
//

#if canImport(XCTest)
import XCTest
@testable import OSCAEssentials
import Foundation

final class UIImageQRCodeTests: XCTestCase {
  /// can I generate an `UIImage` from an deeplink `URL`?
  func testQRCodeImage() throws -> Void {
    guard let url = URL(string: "solingen://pressreleases/detail?object=fbzwMYb6la") else { XCTFail("Not a valid URL string!"); return }
    let qrCodeImage = UIImage(from: url)
    XCTAssertNotNil(qrCodeImage)
  }// endfunc testQRCodeImage
}// end final class UIImageQRCodeTests
#endif
