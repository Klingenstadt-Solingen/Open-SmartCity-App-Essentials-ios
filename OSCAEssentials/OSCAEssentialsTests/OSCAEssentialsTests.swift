//
//  XCTestCase.swift
//  OSCAEssentials
//
//  Reviewed by Stephan Breidenbach on 09.02.22.
//  Reviewed by Stephan Breidenbach on 08.07.2022
//
#if canImport(XCTest)
import XCTest
@testable import OSCAEssentials
import Foundation

final class OSCAEssentialsTests: XCTestCase {
  static let moduleVersion = "1.0.3"
  override func setUpWithError() throws {
    try super.setUpWithError()
  }// end override func setUpWithError
  
  func testModuleInit() throws -> Void {
    let module = makeOSCAEssentials()
    XCTAssertEqual(module.version, OSCAEssentialsTests.moduleVersion)
    XCTAssertEqual(module.bundlePrefix, "de.osca.essentials")
    XCTAssertNotNil(OSCAEssentials.bundle)
  }// end func testModuleInit
}// end final class OSCAEssentialsTests

extension OSCAEssentialsTests {
  public func makeOSCAEssentials() -> OSCAEssentials {
    return OSCAEssentials()
  }// end public func makemakeOSCAEssentials
}// end extension final class OSCAEssentialsTests
#endif
