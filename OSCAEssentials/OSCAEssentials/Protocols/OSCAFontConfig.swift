//
//  OSCAFontConfig.swift
//  OSCAEssentials
//
//  Created by Mammut Nithammer on 17.01.22.
//

import UIKit

public protocol OSCAFontConfig {
    /// display
    var displayHeavy: UIFont { get set }
    var displayLight: UIFont { get set }
    /// headline
    var headlineHeavy: UIFont { get set }
    var headlineLight: UIFont { get set }
    /// title
    var titleHeavy: UIFont { get set }
    var titleLight: UIFont { get set }
    /// sub header
    var subheaderHeavy: UIFont { get set }
    var subheaderLight: UIFont { get set }
    /// body
    var bodyHeavy: UIFont { get set }
    var bodyLight: UIFont { get set }
    /// caption
    var captionHeavy: UIFont { get set }
    var captionLight: UIFont { get set }
    /// small
    var smallHeavy: UIFont { get set }
    var smallLight: UIFont { get set }
}// end public protocol OSCAFontConfig
