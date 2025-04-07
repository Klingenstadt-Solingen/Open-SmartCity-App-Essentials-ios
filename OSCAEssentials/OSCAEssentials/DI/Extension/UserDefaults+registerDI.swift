//
//  UserDefaults+registerDI.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.02.23.
//

import Foundation
extension UserDefaults {
  public static func registerDI() throws -> Void {
    let devDIContainer = DIContainer.container(for: .develop)
    let productionDIContainer = DIContainer.container(for: .production)
    // register developer User defaults closure to DI Container
    devDIContainer.register(.by(type: UserDefaults.self),
                            DIContainer.userDefaults)
    // register production User defaults closure to DI Container
    productionDIContainer.register(.by(type: UserDefaults.self),
                                   DIContainer.userDefaults)
  }// end public static func registerDI
}// end extension class UserDefaults
