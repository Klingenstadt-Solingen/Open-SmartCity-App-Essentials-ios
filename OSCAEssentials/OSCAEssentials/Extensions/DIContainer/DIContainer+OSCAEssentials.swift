//
//  DIContainer+OSCAEssentials.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.02.23.
//

import Foundation

extension DIContainer {
  /// Type property closure for `OSCAEssentials`
  public static var essentials = { (_: Resolvable) throws -> OSCAEssentials in OSCAEssentials() }
}// end extension public struct OSCAEssentials
