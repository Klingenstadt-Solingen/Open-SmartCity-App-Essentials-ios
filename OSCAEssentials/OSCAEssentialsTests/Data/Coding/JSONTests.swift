//
//  JSONTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 24.01.23.
//

#if canImport(XCTest) && canImport(OSCAEssentials)
import Foundation
import XCTest
@testable import OSCAEssentials
import Combine

class JSONTests: XCTestCase {
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
    XCTAssertNotNil(sut.object, "Subject under ist is not a JSON object!")
  }// end func testDecodingJSONData
  
  /// Is it possible to deserialize a `nil`value from `JSON` scheme with key `NullValue`?
  func testDecodingNullValue() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let nullValue: JSON = sut["NullValue"] else { XCTFail("Subject under test doesn't contain 'NullValue'"); return }
    XCTAssertNil(nullValue.null, "`NullValue` is NOT `.null`!")
  }// end func testDecodingNullValue
  
  /// is it possible to deserialize a `Double` value from `JSON` scheme with key `DoubleValue` with an implicit cast to `Double`?
  func testImplicitCastToDouble() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let directDouble: Double = sut["DoubleValue"] else { XCTFail("`DoubleValue` implicit cast isn't possible!"); return }
    XCTAssertEqual(directDouble, 0.999999, accuracy: 0.000001, "`DoubleValue` is not equal to 0.999999!")
  }// end func testImplicitCastToDouble
  
  /// is it possible to deserialize a `Int` value from `JSON` scheme with key `IntValue` with an implicit cast to `Int`?
  func testImplicitCastToInt() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let directInteger: Int = sut["IntValue"]  else { XCTFail("`IntValue` implicit cast isn't possible!"); return }
    XCTAssertEqual(directInteger, 2, "'IntValue' is not equal to 2!")
  }// end func testImplicitCastToInt
  
  /// is it possible to deserialize a `Bool` value from `JSON` scheme with key `BoolValue` with an implicit cast to `Bool`?
  func testImplicitCastToBool() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let directBool: Bool = sut["BoolValue"] else { XCTFail("`BoolValue` implicit cast isn't possible!"); return }
    XCTAssertTrue(directBool, "'BoolValue' is not true!")
  }// end func testImplicitCastToBool
  
  /// is it possible to deserialize a `String` value from `JSON` scheme with key `StringValue` with an implicit cast to `String`?
  func testImplicitCastToString() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let directString: String = sut["StringValue"] else { XCTFail("`StringValue` implicit cast isn't possible!"); return }
    XCTAssertEqual(directString, "String", "'StringValue' is NOT 'String'")
  }// end func testImplicitCastToString
  
  /// Is it possible to deserialize an `Array` from `JSON` scheme with key `ArrayValue` with an implicit cast to `[JSON]`?
  func testImplicitCastToArray() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let directArray: [JSON] = sut["ArrayValue"] else { XCTFail("`ArrayValue` implicit jast isn't possible!"); return }
    XCTAssertTrue(!directArray.isEmpty, "'ArrayValue' is empty!")
    XCTAssertTrue(directArray.count == 3, "'ArrayValue' contains not 3 elements!")
  }// end func testImplicitCastToArray
  
  func testJSONArray() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let array: [JSON] = sut["ArrayValue"] else { XCTFail("`ArrayValue` implicit jast isn't possible!"); return }
    for iIndex in 0..<array.count {
      let object = array[iIndex]
      for jIndex in 0..<3 {
        XCTAssertEqual(object["key\(iIndex)\(jIndex)"],
                       "value\(iIndex)\(jIndex)",
                       "array[\(iIndex)][key\(iIndex)\(jIndex)] is not 'value\(iIndex)\(jIndex)'")
      }// end for j
    }// end for i
  }// end func testJSONArray
  
  /// Is it possible to deserialize an `Object` from `JSON` scheme with key `ObjectValue` with an implicit cast to `[JSON.Key: JSON]`?
  func testImplicitCastToDict() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let directObject: [JSON.Key: JSON] = sut["ObjectValue"] else { XCTFail("Subject under test doesn't contain `ObjectValue`"); return }
    XCTAssertTrue(!directObject.isEmpty)
    XCTAssertTrue(directObject.count == 2)
  }// end func testImplicitCastToDict
  
  /// Is it possible to deserialize an `ParseDate`object from `JSON` scheme with key `ParseDate` with an implicit cast to `ParseDate`?
  func testImplicitCastToParseDate() throws -> Void {
    self.sut = try makeSut()
    guard let sut: JSON = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let object: JSON = sut["ObjectValue"] else { XCTFail("Subject under test doesn't contain 'ObjectValue'"); return }
    guard let directParseDate: ParseDate = object["ParseDate"] else { XCTFail("'ParseDate' is nil!"); return }
    let parseDateReference = ParseDate(timeStampISO: "2022-01-01T12:23:45.678Z")
    XCTAssertEqual(directParseDate, parseDateReference, "'ParseDate' is not equal to reference!")
  }// end func testDecodingParseDateValue
  
  /// is it possible to deserialize a `ParsePointer` value fom `JSON` scheme with key `ParsePointer` with an implicit cast to `ParsePointer`?
  func testImplicitCastToParsePointer() throws -> Void {
    self.sut = try makeSut()
    guard let sut = self.sut else { XCTFail("Subject under test is nil!"); return }
    guard let object: JSON = sut["ObjectValue"] else { XCTFail("Subject under test doesn't contain 'ObjectValue'"); return }
    guard let directParsePointer: ParsePointer = object["ParsePointer"] else { XCTFail("`ParsePointer` implicit cast isn't possible!"); return }
    let parsePointerReference = ParsePointer(className: "GameScore",
                                             objectId: "Ed1nuqPvc")
    XCTAssertEqual(directParsePointer, parsePointerReference, "'ParsePointer' is not equal to reference!")
  }// end func testImplicitCastToParsePointer
}// end class JSONTests

extension JSONTests {
  public enum Error: Swift.Error {
    case notContaining(JSON.Key)
  }// end public enum Error
}// end extension class JSONTests

extension JSONTests {
  public func makeSut() throws -> JSON? {
    guard let data: Data = self.jsonData else { XCTFail("No JSON content available!"); return nil }
    let sut = try? OSCACoding.jsonDecoder().decode(JSON.self, from: data)
    return sut
  }// end public func makeSut
}// end extension class JSONTests

extension JSONTests {
  public func getData(name: String, withExtension: String = ".json") throws -> Data {
    let bundle = Bundle(for: type(of: self))
    let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
    let data = try Data(contentsOf: fileUrl!)
    return data
  }// end func getData
  
  public var jsonData: Data? {
    let name = String(describing: type(of: self))
    let data = try? getData(name: name)
    return data
  }// end var mockContentData
}// end extension JSONTests

extension JSONTests {
  public enum OSCACoding {}
}// end extension JSONTests

extension JSONTests.OSCACoding {
  /// The JSON Encoder setup with the correct `dateEncodingStrategy`
  /// strategy for `OSCA`.
  public static func jsonEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = dateEncodingStrategy
    return encoder
  }// end public static func jsonEncoder
  
  /// The JSON Decoder setup with the correct `dateDecodingStrategy`
  /// strategy for `OSCA`. This encoder is used to decode all data received
  /// from the server.
  public static func jsonDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = dateDecodingStrategy
    return decoder
  }// end public static func jsonDecoder
}// end extension OSCACoding

extension JSONTests.OSCACoding {
  public enum DateEncodingKeys: String, CodingKey {
    case iso
    case type = "__type"
  }
  
  public static let dateFormatter: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return dateFormatter
  }()
  
  public static let dateFormatterWithoutMS: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    return dateFormatter
  }()
  
  public static let dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .custom { date, encoder in
    var container = encoder.container(keyedBy: DateEncodingKeys.self)
    try container.encode("Date", forKey: .type)
    let dateString = dateFormatter.string(from: date)
    try container.encode(dateString, forKey: .iso)
  }
  
  public static let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .custom({ (decoder) -> Date in
    let container = try decoder.singleValueContainer()
    let decodedString = try container.decode(String.self)
    
    if decodedString.contains(".") {
      if let date = dateFormatter.date(from: decodedString) {
        return date
      }
    } else {
      if let date = dateFormatterWithoutMS.date(from: decodedString) {
        return date
      }
    }
    return Date()
  }
  )
}// end extension OSCACoding
#endif
