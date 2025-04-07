//
//  AppConfiguration+registerDI.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.02.23.
//

import Foundation

extension AppConfiguration {
  public static func registerDI() throws -> Void {
    let devDIContainer = DIContainer.container(for: .develop)
    let productionDIContainer = DIContainer.container(for: .production)
    
    // register developer app configuration closure to DI Container
    devDIContainer.register(.by(type: AppConfiguration.self),
                            DIContainer.appConfiguration)
    // register production app configuration closure to DI Cotainer
    productionDIContainer.register(.by(type: AppConfiguration.self),
                                   DIContainer.appConfiguration)
  }// end public static func registerDI
}// end extension public class AppConfiguration
