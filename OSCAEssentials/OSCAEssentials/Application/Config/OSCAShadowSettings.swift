//
//  OSCAShadowSettings.swift
//  OSCAEssentials
//
//  Created by Ömer Kurutay on 25.03.22.
//

import UIKit

public struct OSCAShadowSettings {
    public var color: CGColor
    public var opacity: Float
    public var radius: CGFloat
    public var offset: CGSize
    
    public init(color: CGColor = UIColor.black.cgColor,
                opacity: Float,
                radius: CGFloat,
                offset: CGSize) {
        self.color = color
        self.opacity = opacity
        self.radius = radius
        self.offset = offset
    }
}
