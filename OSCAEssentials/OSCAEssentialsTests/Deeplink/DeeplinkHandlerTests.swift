//
//  DeeplinkHandlerTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 25.08.22.
//

import Foundation
import XCTest
@testable import OSCAEssentials

final class DeeplinkHandlerTests: XCTestCase {
  let key: String = "Id"
  let value: String = "845fa403-f841-4737-9e54-8f2bd76d568b"
  var deeplinkHandler: DeeplinkHandler?
  
  override func setUpWithError() throws {
    self.deeplinkHandler = try makeDeeplinkHandler()
    XCTAssertNotNil(self.deeplinkHandler)
  }// end override func setUpWithError
  
  func testDeeplinkHandlerInit() throws {
    guard let deeplinkHandler = deeplinkHandler else {
      throw DeeplinkHandler.Error.deeplinkHandlerInitFail
    }// end guard
    let url = try makeURL()
    XCTAssertTrue(deeplinkHandler.canOpenURL(url))
  }// end func testDeeplinkHandlerInit
  
  func testGetQueryItemsFromURL() throws {
    guard let deeplinkHandler = deeplinkHandler else {
      throw DeeplinkHandler.Error.deeplinkHandlerInitFail
    }
    let url = try makeURL()
    let queryItems: [URLQueryItem]? = deeplinkHandler.getQueryItems(from: url)
    XCTAssertNotNil(queryItems)
    guard let queryItems = queryItems else {
      throw DeeplinkHandler.Error.queryItemsMissing(urlString: url.absoluteString)
    }// end guard
    XCTAssertTrue(!queryItems.isEmpty)
    let queryItem = queryItems.first
    guard let queryItem = queryItem else {
      throw DeeplinkHandler.Error.queryItemsMissing(urlString: url.absoluteString)
    }// end guard
    XCTAssertEqual(queryItem.name, self.key, "Query item's name is NOT '\(self.key)'")
    XCTAssertEqual(queryItem.value, self.value, "Query item's value is NOT '\(self.value)'")
  }// end func testGetQueryItemsFromURL
  
  func testGetItemsFromURL() throws {
    guard let deeplinkHandler = deeplinkHandler else {
      throw DeeplinkHandler.Error.deeplinkHandlerInitFail
    }// end guard
    let url = try makeURL()
    let items: [String: String]? = deeplinkHandler.getItems(from: url)
    XCTAssertNotNil(items)
    guard let items = items else {
      throw DeeplinkHandler.Error.queryItemsMissing(urlString: url.absoluteString)
    }// end guard
    XCTAssertTrue(!items.isEmpty)
    XCTAssertTrue(items.keys.contains(where: {$0 == self.key}), "Items doesn't contain the property key '\(self.key)'")
    guard let id = items[self.key] else {
      throw DeeplinkHandler.Error.queryItemsMissing(urlString: url.absoluteString)
    }// end guard
    XCTAssertTrue(id == self.value, "Item's value is NOT '\(self.value)'")
  }// end func testGetItemsFromURL
  
}// end final class DeeplinkHandlerTests

// MARK: - Factory methods
extension DeeplinkHandlerTests {
  public func makeURL() throws -> URL {
    let urlString = "oscacore://test/2?\(self.key)=\(self.value)"
    guard let url = URL(string: urlString)
    else { throw DeeplinkHandler.Error.malformedURLString(urlString: urlString) }
    return url
  }// end public func makeURL
  
  public func makeDeeplinkHandler() throws -> DeeplinkHandler {
    let url = try makeURL()
    let dependencies = DeeplinkHandler.Dependencies(deeplinkURL: url.absoluteString)
    let deeplinkHandler = DeeplinkHandler(dependencies: dependencies)
    return deeplinkHandler
  }// end public func makeDeeplinkHandler
}// end extension class DeeplinkHandlerTests
