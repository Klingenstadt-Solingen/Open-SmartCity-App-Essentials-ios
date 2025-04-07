//
//  OSCAEssentials+registerDI.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.02.23.
//

import Foundation

extension OSCAEssentials {
  public static func registerDI() throws -> Void {
    let devDIContainer = DIContainer.container(for: .develop)
    let productionDIContainer = DIContainer.container(for: .production)
    // register developer essentials
    devDIContainer.register(.by(type: OSCAEssentials.self),
                            DIContainer.essentials)
    // regiser production essentials
    productionDIContainer.register(.by(type: OSCAEssentials.self),
                                   DIContainer.essentials)
  }// end public static func registerDI
}// end extension public struct OSCAEssentials
