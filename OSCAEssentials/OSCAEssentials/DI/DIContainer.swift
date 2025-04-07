//
//  DIContainer.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 23.12.22.
//  based upon git@github.com:Tavernari/DIContainer.git
//  more information: https://medium.com/tribalscale/building-a-flexible-dependency-injection-library-for-swift-e92d68e02aec
//

import Foundation

public class DIContainer: Injectable {
  public var config: OSCAConfig
  /// Type property `DIContainer.containers`
  private static let containers: [OSCAConfig: DIContainer] = [.production: DIContainer(config: .production),
                                                              .develop: DIContainer(config: .develop),
                                                              .mock: DIContainer(config: .mock)]
  
  /// Type property `DIContainer.standard`
  public static var standard = DIContainer()
  
  public static func container(for config: OSCAConfig) -> DIContainer { self.containers[config]! }
  
  public var dependencyInitializer: [AnyHashable : (Resolvable) throws -> Any] = [:]
  public var dependencyShared: [AnyHashable : Any] = [:]
  
  public required init(config: OSCAConfig = .develop) {
    self.config = config
  }// end required init
}// end public class DIContainer

/// Inject dependency by simply annotating a property with `@Injected propertyWrapper`
@propertyWrapper
public struct Injected<DependencyType> {
  public static func container() -> Injectable { DIContainer.standard }
  
  public init(_ identifier: InjectIdentifier<DependencyType> = .by(type: DependencyType.self),
              container: Resolvable = Self.container(),
              mode: ResolveMode = .shared) {
    do {
      let resolved = try container.resolve(identifier,
                                       mode: mode)
      self.wrappedValue = resolved
    } catch {
      fatalError( error.localizedDescription )
    }// end do catch
  }// end public init
  
  private(set) public var wrappedValue: DependencyType
}// end @propertyWrapper public struct Injected

/// Inject depenency `lazy` by simply annotating a property with `@LazyInjected propertyWrapper`
/// Since the dependencies are declared as `@LazyInjected` the injection will be deferred until the object is used. This allows time for the dependency to be registered before it’s attempted to be injected and it prevents recursion of the injecting of properties.
@propertyWrapper
public struct LazyInjected<DependencyType> {
  public static func container() -> Injectable { DIContainer.standard }
  
  private let identifier: InjectIdentifier<DependencyType>
  private let container: Resolvable
  private let mode: ResolveMode
  public init(_ identifier: InjectIdentifier<DependencyType>? = nil,
              container: Resolvable? = nil,
              mode: ResolveMode = .shared) {
    self.identifier = identifier ?? .by(type: DependencyType.self)
    self.container = container ?? Self.container()
    self.mode = mode
  }// end public init
  
  private(set) public lazy var wrappedValue: DependencyType = {
    do {
      return try container.resolve(identifier,
                                   mode: mode)
    } catch {
      fatalError( error.localizedDescription )
    }// end do catch
  }()// end public lazy var wrappedValue

}// end @propertyWrapper public struct LazyInjected

/// Inject optional dependency by simply annotating a property with `@InjectedSafe propertyWrapper`
@propertyWrapper
public struct InjectedSafe<DependencyType> {
  public static func container() -> Injectable { DIContainer.standard }
  
  public init(_ identifier: InjectIdentifier<DependencyType> = .by(type: DependencyType.self),
              container: Resolvable = container(),
              mode: ResolveMode = .shared) {
    let resolved = try? container.resolve(identifier,
                                         mode: mode)
    self.wrappedValue = resolved
  }// end public init
  
  private(set) public var wrappedValue: DependencyType?
}// end @propertyWrapper public struct InjectedSafe

/// Inject optional depenency `lazy` by simply annotating a property with `@LazyInjectedSafe propertyWrapper`
/// Since the dependencies are declared as `@LazyInjectedSafe` the injection will be deferred until the object is used. This allows time for the dependency to be registered before it’s attempted to be injected and it prevents recursion of the injecting of properties.
@propertyWrapper
public struct LazyInjectedSafe<DependencyType> {
  public static func container() -> Injectable { DIContainer.standard }
  
  private let identifier: InjectIdentifier<DependencyType>
  private let container: Resolvable
  private let mode: ResolveMode
  public init(_ identifier: InjectIdentifier<DependencyType>? = nil,
              container: Resolvable? = nil,
              mode: ResolveMode = .shared) {
    self.identifier = identifier ?? .by(type: DependencyType.self)
    self.container = container ?? Self.container()
    self.mode = mode
  }// end public init
  
  private(set) public lazy var wrappedValue: DependencyType? = try? container.resolve(identifier,
                                                                                      mode: mode)
}// end @propertyWrapper public struct LazyInjectedSafe

/// Inject dependency by simply annotating a property with `@WeakInjected propertyWrapper`
/// This `weak` reference will allow us to remove/clear out the container and cause the references within other classes to fall out of memory as well.
///
/// A Note with the `@WeakInjected propertyWrapper` is that you either need to always use the `shared` resolve mode, or if you are using the `new` resolve mode then you need to keep a strong reference yourself to the object.
@propertyWrapper
public struct WeakInjected<DependencyType> {
  public static func container() -> Injectable { DIContainer.standard }
  private weak var underlyingValue: AnyObject?
  
  public var wrappedValue: DependencyType? {
    return underlyingValue as? DependencyType
  }// end public var wrappedValue
  
  public init(_ identifier: InjectIdentifier<DependencyType> = InjectIdentifier.by(type: DependencyType.self),
              container: Resolvable = container(),
              mode: ResolveMode = .shared
  ) {
    self.underlyingValue = try? container.resolve(identifier,
                                             mode: mode) as AnyObject
  }// end public init
}// end @propertyWrapper public struct WeakInjected
