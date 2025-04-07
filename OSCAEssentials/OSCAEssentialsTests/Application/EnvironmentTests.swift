//
//  EnvironmentTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 05.09.22.
//

import Foundation
import XCTest
@testable import OSCAEssentials

final class EnvironmentTests: XCTestCase {
  var apiDict: [String:Any]?
  var apiDictDev: [String:Any]?
  
  override func setUpWithError() throws {
    self.apiDict = makeAPIDict()
    XCTAssertNotNil(self.apiDict)
    self.apiDictDev = makeAPIDictDev()
    XCTAssertNotNil(self.apiDictDev)
  }// end override func setUpWithError
  
  func testApiData() throws {
    let apiData = Environment.apiData
    XCTAssertNotNil(apiData, "No Data in plist")
  }// end func testApiData
  
  func testApiDataDev() throws {
    let apiDataDev = Environment.apiDataDev
    XCTAssertNotNil(apiDataDev, "No Data in plist")
  }// end func testApiDataDev
  
  func testDefaultGeoPoint() throws {
    let defaultGeoPoint = Environment.defaultGeoPoint
    XCTAssertNotNil(defaultGeoPoint, "No default geo point in plist")
  }// end func testDefaultGeoPoint
  
  func testDefaultGeoPointStruct() throws {
    let defaultGeoPointStruct = Environment.defaultGeoPointStruct
    XCTAssertNotNil(defaultGeoPointStruct, "No default geo point in plist")
  }// end func testDefaultGeoPointStruct
  
  func testParseAPIRootURL() throws {
    let parseAPIRootURL = Environment.parseAPIRootURL
    XCTAssertNotNil(parseAPIRootURL, "No parse API root URL in plist")
    XCTAssertTrue(!parseAPIRootURL.isEmpty, "parse API root URL is empty")
  }// end func testParseAPIRootURL
  
  func testParseAPIKey() throws {
    let parseAPIKey = Environment.parseAPIKey
    XCTAssertNotNil(parseAPIKey, "No parse API key in plist")
    XCTAssertTrue(!parseAPIKey.isEmpty, "parse API key is empty")
  }// end func testParseAPIKey
  
  func testParseRESTAPIKey() throws {
    let parseRESTAPIKey = Environment.parseRESTAPIKey
    XCTAssertNotNil(parseRESTAPIKey, "No parse REST API key in plist")
    XCTAssertTrue(!parseRESTAPIKey.isEmpty, "parse REST API key is empty")
  }// end func testParseRESTAPIKey
  
  func testParseMasterKey() throws {
    let parseMasterKey = Environment.parseMasterAPIKey
    XCTAssertNotNil(parseMasterKey, "No parse master API key in plist")
    XCTAssertTrue(!parseMasterKey.isEmpty, "parse master API key is empty")
  }// end func testParseMasterKey
  
  func testParseApplicationID() throws {
    let parseApplicationID = Environment.parseMasterAPIKey
    XCTAssertNotNil(parseApplicationID, "No parse application ID in plist")
    XCTAssertTrue(!parseApplicationID.isEmpty, "parse application ID is empty")
  }// end func testParseApplicationID
  
  func testParseAPIRootURLDev() throws {
    let parseAPIRootURLDev = Environment.parseAPIRootURLDev
    XCTAssertNotNil(parseAPIRootURLDev, "No parse API root URL in plist")
    XCTAssertTrue(!parseAPIRootURLDev.isEmpty, "parse API root URL is empty")
  }// end func testParseAPIRootURLDev
  
  func testParseAPIKeyDev() throws {
    let parseAPIKeyDev = Environment.parseAPIKeyDev
    XCTAssertNotNil(parseAPIKeyDev, "No parse API key in plist")
    XCTAssertTrue(!parseAPIKeyDev.isEmpty, "parse API key is empty")
  }// end func testParseAPIKeyDev
  
  func testParseRESTAPIKeyDev() throws {
    let parseRESTAPIKeyDev = Environment.parseRESTAPIKeyDev
    XCTAssertNotNil(parseRESTAPIKeyDev, "No parse REST API key in plist")
    XCTAssertTrue(!parseRESTAPIKeyDev.isEmpty, "parse REST API key is empty")
  }// end func testParseRESTAPIKeyDev
  
  func testParseMasterKeyDev() throws {
    let parseMasterAPIKeyDev = Environment.parseMasterAPIKeyDev
    XCTAssertNotNil(parseMasterAPIKeyDev, "No parse master API key in plist")
    XCTAssertTrue(!parseMasterAPIKeyDev.isEmpty, "parse master API key is empty")
  }// end func testParseMasterKeyDev
  
  func testParseApplicationIDDev() throws {
    let parseMasterAPIKeyDev = Environment.parseMasterAPIKeyDev
    XCTAssertNotNil(parseMasterAPIKeyDev, "No parse application ID in plist")
    XCTAssertTrue(!parseMasterAPIKeyDev.isEmpty, "parse application ID is empty")
  }// end func testParseApplicationIDDev
}// end final class EnvironmentTests

extension EnvironmentTests {
  public func makeAPIDict() -> [String:Any] {
    return Environment.apiDictionary
  }// end public func makeAPIDict
  
  public func makeAPIDictDev() -> [String: Any] {
    return Environment.apiDictionaryDev
  }// end public func makeAPIDictDev
}
