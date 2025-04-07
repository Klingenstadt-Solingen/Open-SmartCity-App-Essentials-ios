//
//  UserDefaults+ObjectSavableTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 04.07.22.
//
#if canImport(OSCATestCaseExtension)
import Foundation
import XCTest
import OSCATestCaseExtension
@testable import OSCAEssentials

final class ObjectSavableTests: XCTestCase {
  let key: String = "OSCADeviceInfo"
  var sut: UserDefaults?
  var object: OSCADeviceInfo?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    self.sut = try makeUserDefaults(domainString: "de.solingen.app")
    self.object = try makeDeviceInfo()
  }// end override func setUpWithError
  
  func testInit() throws -> Void {
    XCTAssertNotNil(self.sut)
    XCTAssertNotNil(self.object)
  }// end func testInit
  
  func testSetGetObject() throws -> Void {
    guard let userDefaults = self.sut
    else { throw OSCAObjectSavableError.noValidUserDefaults }
    guard let object = object else {
      return XCTFail("No initialized object available!")
    }// end guard
    // save object in user defaults with key
    XCTAssertNoThrow(try userDefaults.setObject(object, forKey: self.key))
    // retrieve object from user defaults for key
    let retrievedObject = try userDefaults.getObject(forKey: self.key, castTo: OSCADeviceInfo.self)
    // objects are equal
    XCTAssertEqual(retrievedObject, object)
  }// end func testSetGetObject
}// end final class ObjectSavableTests

// MARK: - factory methods
extension ObjectSavableTests {
  
}// end extension final class ObjectSavableTests
#endif
