//
//  OSCAParseConfigTests.swift
//  OSCAContactTests
//
//  Created by Stephan Breidenbach on 01.02.23.
//

#if canImport(XCTest) && canImport(OSCATestCaseExtension)
import Foundation
import OSCAEssentials
import OSCANetworkService
import Combine
@testable import OSCAEssentials
import XCTest
import OSCATestCaseExtension

/// ```console
/// curl -X GET \
///  -H "X-Parse-Application-Id: APPLICATION_ID" \
///  -H "X-Parse-Client-Key: API_CLIENT_KEY" \
///  https://parse-dev.solingen.de/config \
///  | python3 -m json.tool
///  | pygmentize -g
///  ```
class OSCAParseConfigTests: XCTestCase {
  private var cancellables: Set<AnyCancellable>!
  var sut: JSON!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    // initialize cancellables
    self.cancellables = []
  }// end override func setupWithError
  
  override func tearDownWithError() throws {
    self.sut = nil
    if !self.cancellables.isEmpty {
      self.cancellables.forEach { $0.cancel() }
      self.cancellables.removeAll()
    }// end if
    try super.tearDownWithError()
  }// end override open func tearDownWithError
  
  
  /// Is there a file with the `JSON` scheme example data available?
  /// The file name has to match with the test class name: `JSONTests.json`
  func testJSONDataAvailable() throws -> Void {
    // `give`
    
    // `when`
    let jsonData = self.jsonData
    // `then`
    XCTAssertNotNil(jsonData, "No json content available!")
  }// end open func testJSONDataAvailable
  
  /// Is it possible to deserialize `JSON` scheme example data to an array of generic `ParseObject` 's?
  func testDecodingJSONData() throws -> Void {
    // `give`
    
    // `when`
    
    // `then`
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    XCTAssertNotNil(sut, "Subject under ist is not a JSON object!")
  }// end func testDecodingJSONData
  
  /// Is it possible to deserialize an `Object` from `JSON` scheme with key `params` with an implicit cast to `JSON`?
  func testParamsExistsInJSON() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let params: JSON = sut["params"] else { XCTFail("Subject under test doesn't contain `params`"); return }
    XCTAssertNotNil(params)
  }// end func testParamsExistsInJSON
  
  /// is it possible to deserialize a `String` value from `JSON` scheme with key `StringValue` with an implicit cast to `String`?
  func testImplicitCastToString() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let params: JSON = sut["params"] else { XCTFail("Subject under test doesn't contain `params`"); return }
    guard let privacyTextString: String = params["privacyText"] else { XCTFail("`privacyText` implicit cast isn't possible!"); return }
    XCTAssertEqual(privacyTextString, "Privacy Text Test", "'StringValue' is NOT 'String'")
  }// end func testImplicitCastToString
}// end class OSCAParseConfigTests

extension OSCAParseConfigTests {
  public enum Error: Swift.Error {
    case notContaining(JSON.Key)
  }// end public enum Error
}// end extension class OSCAParseConfigTests

extension OSCAParseConfigTests {
  public func makeSut() throws -> JSON? {
    guard let data: Data = self.jsonData else { XCTFail("No JSON content available!"); return nil }
    let sut = try? OSCACoding.jsonDecoder().decode(JSON.self, from: data)
    return sut
  }// end public func makeSut
}// end extension class OSCAParseConfigTests
#endif

