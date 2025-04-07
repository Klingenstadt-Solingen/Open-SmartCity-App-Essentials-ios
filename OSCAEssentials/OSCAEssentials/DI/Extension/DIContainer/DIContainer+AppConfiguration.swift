//
//  DIContainer+AppConfiguration.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.02.23.
//

import Foundation

extension DIContainer {
  /// Type property closure `AppConfiguration`
  public static var appConfiguration = { (_: Resolvable) throws -> AppConfiguration in AppConfiguration() }
}// end extension public DIContainer
