//
//  DIContainer+UserDefaults.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.02.23.
//

import Foundation

extension DIContainer {
  /// Type property closre for `UserDefaults`
  public static var userDefaults = { (_: Resolvable) throws -> UserDefaults in UserDefaults.standard }
}// end extension public class DIContainer
