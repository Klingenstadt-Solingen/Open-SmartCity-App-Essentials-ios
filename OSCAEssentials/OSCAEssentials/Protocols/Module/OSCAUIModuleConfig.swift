//
//  OSCAUIModuleConfig.swift
//  OSCAEssentials
//
//  Created by Mammut Nithammer on 17.01.22.
//

import Foundation

public protocol OSCAUIModuleConfig {
    var title           : String?           { get set }
    var fontConfig      : OSCAFontConfig    { get set }
    var colorConfig     : OSCAColorConfig   { get set }
}// end public protocol OSCAUIModuleConfig
