//
//  OSCAModule.swift
//  OSCAEssentials
//
//  Created by Mammut Nithammer on 17.01.22.
//

import Foundation

public protocol OSCAModule {
  var version: String { get }
  var bundlePrefix: String { get }
}// end public protocol OSCAModule

public protocol OSCAModuleDependencies {
  var networkService: OSCANetworkServiceProtocol { get }
  var userDefaults: UserDefaults { get }
}// end public protocol OSCAModuleDependencies
