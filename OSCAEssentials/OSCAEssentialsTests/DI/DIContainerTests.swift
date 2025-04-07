//
//  DIContainerTests.swift
//  OSCAEssentialsTests
//
//  Created by Stephan Breidenbach on 23.12.22.
//

import XCTest
@testable import OSCAEssentials

final class DIContainerTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    try super.tearDownWithError()
    
    DIContainer.standard.removeAllDependencies()
  }// end override func tearDownWithError
  
  func testAnyHashable() throws {
    let closure = { (dIContainer: Resolvable) throws -> String in
      guard let diContainer = dIContainer as? DIContainer else { throw DIContainer.Error.notImplemented }
      return "\(diContainer.config)"
    }
    let key = InjectIdentifier.by(type: String.self)
    DIContainer.standard.register(key,
                                  closure)
    var string: String?
    XCTAssertNoThrow(string = try DIContainer.standard.resolve(InjectIdentifier.by(type: String.self)))
    XCTAssertNotNil(string)
  }
  
  func testResolveUnavailableInjection() throws {
    let identifier = InjectIdentifier<String>.by(key: "key")
    XCTAssertThrowsError(try DIContainer.standard.resolve(identifier))
  }// end func testResolveUnavailableInjection
  
  func testRegisterContainerWithKeyOnIdentifier() throws {
    let value = "result"
    let key = "key"
    
    DIContainer.standard.register(.by(key: key)) { _ in
      return value
    }// end register key result
    
    let resultValue: String = try DIContainer.standard.resolve(.by(key: key))
    
    XCTAssertEqual(resultValue, value)
  }// end func testRegisterContainerWithKeyOnIdentifier
  
  func testRegisterContainerWithKey() throws {
    let value = "result"
    let key = "key"
    
    DIContainer.standard.register(key: key) { _ in
      return value
    }// end register key result
    
    let resultValue: String = try DIContainer.standard.resolve(.by(key: key))
    
    XCTAssertEqual(resultValue, value)
  }// end func testRegisterContainerWithKey
  
  func testRegisterContainerWithTypeOnIdentifier() throws {
    let valueResult = DIContainerTests.ValueResult(resultString: "resultString")
    
    DIContainer.standard.register(type: DIContainerTests.ValueResult.self) { _ in
      return valueResult
    }// end register type
    
    let resolvedValueResult = try DIContainer.standard.resolve(.by(type: DIContainerTests.ValueResult.self))
    
    XCTAssertEqual(valueResult, resolvedValueResult)
    
  }// end func testRegisterContainerWithTypeOnIdentifier
  
  func testRegisterContainerWithType() throws {
    let valueResult = DIContainerTests.ValueResult(resultString: "resultString")
    
    DIContainer.standard.register(.by(type: DIContainerTests.ValueResult.self)) { _ in
      return valueResult
    }// end register by type
    
    let resolvedValueResult = try DIContainer.standard.resolve(.by(type: DIContainerTests.ValueResult.self))
    
    XCTAssertEqual(valueResult, resolvedValueResult)
  }// end func testRegisterContainerWithType
  
  func testRemoveFromContainerWithTypeOnIdentifier() throws {
    let valueResult = DIContainerTests.ValueResult(resultString: "resultString")
    
    DIContainer.standard.register(.by(type: DIContainerTests.ValueResult.self)) { _ in
      return valueResult
    }// end register by type
    
    let identifier = InjectIdentifier.by(type: ValueResult.self)
    
    XCTAssertNotNil(DIContainer.standard.dependencyInitializer[identifier])
    
    _ = try DIContainer.standard.resolve(identifier,
                                                      mode: .shared)
    XCTAssertNotNil(DIContainer.standard.dependencyShared[identifier])
    
    DIContainer.standard.remove(.by(type: ValueResult.self))
    
    XCTAssertNil(DIContainer.standard.dependencyInitializer[identifier])
    XCTAssertNil(DIContainer.standard.dependencyShared[identifier])
  }// end func testRemoveFromContainerWithTypeOnIdentifier
  
  func testRemoveFromContainerWithType() throws {
    let valueResult = DIContainerTests.ValueResult(resultString: "resultString")
    
    DIContainer.standard.register(type: ValueResult.self) { _ in
      return valueResult
    }
    
    let identifier = InjectIdentifier.by(type: ValueResult.self)
    
    XCTAssertNotNil(DIContainer.standard.dependencyInitializer[identifier])
    _ = try DIContainer.standard.resolve(identifier,
                                                          mode: .shared)
    XCTAssertNotNil(DIContainer.standard.dependencyShared[identifier])
    
    DIContainer.standard.remove(type: ValueResult.self)
    
    XCTAssertNil(DIContainer.standard.dependencyInitializer[identifier])
    XCTAssertNil(DIContainer.standard.dependencyShared[identifier])
  }// end testRemoveFromContainerWithType
  
  func testWrapperInjectByKey() {
    
    let expectedResult = "result"
    
    DIContainer.standard.register(.by(key: "textKey")) { _ in
      
      return expectedResult
    }
    
    let wrapperTest = DIContainerTests.WrapperTest()
    
    XCTAssertEqual(wrapperTest.text, expectedResult)
  }// end testWrapperInjectByKey
  
  func testWrapperInjectByType() {
    
    let expectedResult = "result"
    
    DIContainer.standard.register(.by(type: String.self)) { _ in
      
      return expectedResult
    }
    
    let wrapperTest = WrapperTestByType()
    
    XCTAssertEqual(wrapperTest.text, expectedResult)
    XCTAssertEqual(wrapperTest.textSafe!, expectedResult)
  }// end testWrapperInjectByType
  
  func testWrapperInjectByStructType() {
    
    let expectedResult = "result"
    
    DIContainer.standard.register(.by(type: String.self)) { _ in
      
      return expectedResult
    }
    
    let wrapperTest = WrapperTestByStructType()
    
    XCTAssertEqual(wrapperTest.text, expectedResult)
    XCTAssertEqual(wrapperTest.textSafe!, expectedResult)
  }// end testWrapperInjectByStructType
  
  func testLazyWrapperInjectByType() {
    DIContainer.standard.register(.by(type: NetworkingLayer.self)) { _ in
      return AppNetworkingLayer()
    }// end register
    XCTAssertNotNil(DIContainer.standard.dependencyInitializer[InjectIdentifier.by(type: NetworkingLayer.self)])
    
    DIContainer.standard.register(.by(type: DIContainerTests.UserCache.self)) { _ in
      return UserCache()
    }// end register
    XCTAssertNotNil(DIContainer.standard.dependencyInitializer[InjectIdentifier.by(type: UserCache.self)])
    let request = AppNetworkingLayer().makeRequest()
    XCTAssertEqual(request, "AppNetworkingLayer made a request with user: John Doe")
  }// end func testLazyWrapperInjectByType
  
}// end final class DIContainerTests

// MARK: - nested type ValueResult
extension DIContainerTests {
  struct ValueResult {
    let resultString: String
  }// end struct DIContainerTests.ValueResult
}// end extension DIContainerTests

extension DIContainerTests.ValueResult: Equatable {}

extension DIContainerTests {
  class WrapperTest {
    
    @Injected(.by(key: "textKey"))
    var text: String
  }// end class WrapperTest
}// end extension final class DIContainerTests

extension DIContainerTests {
  class WrapperTestByType {
    
    @Injected
    var text: String
    
    @InjectedSafe
    var textSafe: String?
  }// end class WrapperTestByType
}// end extension final class DIContainerTests

extension DIContainerTests {
  struct WrapperTestByStructType {
    
    @Injected
    var text: String
    
    @InjectedSafe
    var textSafe: String?
  }// end struct WrapperTestByStructType
}// end extension final class DIContainerTests

protocol NetworkingLayer: AnyObject {
  func makeRequest() -> String
}// end protocol NetworkingLayer

extension DIContainerTests {
  class UserCache {
    @LazyInjected
    var network: NetworkingLayer
    
    let user: String = "John Doe"
  }// end class UserCache
  
  class AppNetworkingLayer: NetworkingLayer {
    @LazyInjected
    var user: DIContainerTests.UserCache
    
    func makeRequest() -> String {
      return "AppNetworkingLayer made a request with user: \(self.user.user)"
    }// end func makeRequest
  }// end class AppNetworkingLayer
}// end extension final class DIContainerTests
