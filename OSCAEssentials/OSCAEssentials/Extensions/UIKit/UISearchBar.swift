//
//  UISearchBar.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 29.03.22.
//

import UIKit

public extension UISearchBar {
    func enable() {
        isUserInteractionEnabled = true
        alpha = 1.0
    }// end public func enable
    
    func disable() {
        isUserInteractionEnabled = false
        alpha = 0.5
    }// end public func disable
}// end public extension class UISearchBar
