//
//  Injectable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 23.12.22.
//  based upon git@github.com:Tavernari/DIContainer.git
//  more information: https://medium.com/tribalscale/building-a-flexible-dependency-injection-library-for-swift-e92d68e02aec
//


import Foundation

public protocol Injectable: Resolvable, AnyObject {
  init(config: OSCAConfig)
  
  var config: OSCAConfig { get }
  
  var dependencyInitializer: [AnyHashable: (Resolvable) throws -> Any] { get set }
  
  var dependencyShared: [AnyHashable: Any] { get set }
  
  func register<DependencyType>(_ identifier: InjectIdentifier<DependencyType>,
                                _ resolve: @escaping (Resolvable) throws -> DependencyType)
  func register<DependencyType>(type: DependencyType.Type?,
                                key: String?,
                                _ resolve: @escaping (Resolvable) throws -> DependencyType)
  
  func remove<DependencyType>(_ identifier: InjectIdentifier<DependencyType>)
}// end public protocol Injectable

public extension Injectable {
  func register<DependencyType>(_ identifier: InjectIdentifier<DependencyType>,
                                _ resolve: @escaping (Resolvable) throws -> DependencyType) {
    dependencyInitializer[identifier] = resolve
  }// end func register
  
  func register<DependencyType>(type: DependencyType.Type? = nil,
                                key: String? = nil,
                                _ resolve: @escaping (Resolvable) throws -> DependencyType) {
    self.register(.by(type: type, key: key),
                  resolve)
  }// end func register type key resolve
  
  func remove<DependencyType>(_ identifier: InjectIdentifier<DependencyType>) {
    self.dependencyInitializer.removeValue(forKey: identifier)
    self.dependencyShared.removeValue(forKey: identifier)
  }// end func remove value
  
  func remove<DependencyType>(type: DependencyType.Type? = nil,
                              key: String? = nil) {
    let identifier = InjectIdentifier.by(type: type, key: key)
    remove(identifier)
  }// end func remove value type, key
  
  func removeAllDependencies() {
    self.dependencyInitializer.removeAll()
    self.dependencyShared.removeAll()
  }// end func removeAllDependencies
  
  func resolve<DependencyType>(_ identifier: InjectIdentifier<DependencyType>,
                               mode: ResolveMode = .shared) throws -> DependencyType {
#if DEBUG
    print("\(String(describing: Self.self)): \(#function)")
#endif
    switch mode {
    case .new:
      guard let resolve = dependencyInitializer[identifier] else {
        throw ResolvableError.dependencyNotFound(identifier.type, identifier.key)
      }
      guard let newDependency = try resolve(self) as? DependencyType else {
        throw ResolvableError.cast(identifier.type)
      }
      return newDependency
    case .shared:
      if dependencyShared[identifier] == nil,
         let resolve = dependencyInitializer[identifier],
         // let dependency = try dependencyInitializer[identifier]?(self)
         let dependency = try? resolve(self) {
        dependencyShared[identifier] = dependency
      }
      guard let sharedDependency = dependencyShared[identifier] as? DependencyType else {
        throw ResolvableError.cast(identifier.type)
      }
      return sharedDependency
    }// end switch case
  }// end func resove identifier
  
  func resolve<DependencyType>(type: DependencyType.Type? = nil,
                               key: String? = nil,
                               mode: ResolveMode = .shared) throws -> DependencyType {
#if DEBUG
    print("\(String(describing: Self.self)): \(#function)")
#endif
    let resolved = try self.resolve(.by(type: type, key: key),
                     mode: mode)
    return resolved
  }// end public func resove type key
}// end public extension protocol Injectable

