//
//  OSCAColorVariants.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 10.03.22.
//

import Foundation

public enum OSCAColorVariants: String {
    case darker     = "darker"
    case dark       = "dark"
    case baseColor  = "base color"
    case light      = "light"
    case lighter    = "lighter"
}// end enum OSCAColorVariants

// - MARK: CaseIterable conformance
extension OSCAColorVariants: CaseIterable {
    
}// end extension enum OSCAColorVariants
