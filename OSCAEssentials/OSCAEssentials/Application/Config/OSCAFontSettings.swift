//
//  OSCAFontSettings.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.01.22.
//
import UIKit

/**
 App-wide font settings, conforming to `OSCAFontConfig`-protocol
 */
public struct OSCAFontSettings: OSCAFontConfig, Equatable {
    
    public enum Keys: String, CaseIterable {
        /// default 36px
        case displayHeavy   = "Display Heavy"
        /// default 36px
        case displayLight   = "Display Light"
        /// default 24px
        case headlineHeavy  = "Headline Heavy"
        /// default 24px
        case headlineLight  = "Headline Light"
        /// default 20px
        case titleHeavy     = "Title Heavy"
        /// default 20px
        case titleLight     = "Title Light"
        /// default 16px
        case subheaderHeavy = "Sub Header Heavy"
        /// default 16px
        case subheaderLight = "Sub Header Light"
        /// default 14px
        case bodyHeavy      = "Body Heavy"
        /// default 14px
        case bodyLight      = "Body Light"
        /// default 12px
        case captionHeavy   = "Caption Heavy"
        /// default 12px
        case captionLight   = "Caption Light"
        /// default 10px
        case smallHeavy     = "Small Heavy"
        /// default 10px
        case smallLight     = "Small Light"
    }// end enum OSCAFontSettings.Keys
    /// type face display heavy
    public var displayHeavy     : UIFont = .systemFont(ofSize: 36, weight: .bold)
    /// type face disply light
    public var displayLight     : UIFont = .systemFont(ofSize: 36, weight: .regular)
    /// type face headline heavy
    public var headlineHeavy    : UIFont = .systemFont(ofSize: 24, weight: .bold)
    /// type face headline lght
    public var headlineLight    : UIFont = .systemFont(ofSize: 24, weight: .regular)
    /// type face title heavy
    public var titleHeavy       : UIFont = .systemFont(ofSize: 20, weight: .bold)
    /// type face title light
    public var titleLight       : UIFont = .systemFont(ofSize: 20, weight: .regular)
    /// type face sub header heavy
    public var subheaderHeavy   : UIFont = .systemFont(ofSize: 16, weight: .bold)
    /// type face sub header light
    public var subheaderLight   : UIFont = .systemFont(ofSize: 16, weight: .regular)
    /// type face body heavy
    public var bodyHeavy        : UIFont = .systemFont(ofSize: 14, weight: .bold)
    /// type face body light
    public var bodyLight        : UIFont = .systemFont(ofSize: 14, weight: .regular)
    /// type face caption heavy
    public var captionHeavy     : UIFont = .systemFont(ofSize: 12, weight: .bold)
    /// type face caption Light
    public var captionLight     : UIFont = .systemFont(ofSize: 12, weight: .regular)
    /// type face small heavy
    public var smallHeavy       : UIFont = .systemFont(ofSize: 10, weight: .bold)
    /// type face small light
    public var smallLight       : UIFont = .systemFont(ofSize: 10, weight: .regular)

    public init(displayHeavy    : UIFont = .systemFont(ofSize: 36, weight: .bold),
                displayLight    : UIFont = .systemFont(ofSize: 36, weight: .regular),
                headlineHeavy   : UIFont = .systemFont(ofSize: 24, weight: .bold),
                headlineLight   : UIFont = .systemFont(ofSize: 24, weight: .regular),
                titleHeavy      : UIFont = .systemFont(ofSize: 20, weight: .bold),
                titleLight      : UIFont = .systemFont(ofSize: 20, weight: .regular),
                subheaderHeavy  : UIFont = .systemFont(ofSize: 16, weight: .bold),
                subheaderLight  : UIFont = .systemFont(ofSize: 16, weight: .regular),
                bodyHeavy       : UIFont = .systemFont(ofSize: 14, weight: .bold),
                bodyLight       : UIFont = .systemFont(ofSize: 14, weight: .regular),
                captionHeavy    : UIFont = .systemFont(ofSize: 12, weight: .bold),
                captionLight    : UIFont = .systemFont(ofSize: 12, weight: .regular),
                smallHeavy      : UIFont = .systemFont(ofSize: 10, weight: .bold),
                smallLight      : UIFont = .systemFont(ofSize: 10, weight: .regular)) {
        self.displayHeavy   = displayHeavy
        self.displayLight   = displayLight
        self.headlineHeavy  = headlineHeavy
        self.headlineLight  = headlineLight
        self.titleHeavy     = titleHeavy
        self.titleLight     = titleLight
        self.subheaderHeavy = subheaderHeavy
        self.subheaderLight = subheaderLight
        self.bodyHeavy      = bodyHeavy
        self.bodyLight      = bodyLight
        self.captionHeavy   = captionHeavy
        self.captionLight   = captionLight
        self.smallHeavy     = smallHeavy
        self.smallLight     = smallLight
    }// end public memberwise init
    
    /// get the type face by key
    /// - Parameter by key: type face key
    public func getTypeFace(by key: OSCAFontSettings.Keys) -> UIFont {
        switch key {
        case .displayHeavy   :
            return self.displayHeavy
        case .displayLight   :
            return self.displayLight
        case .headlineHeavy  :
            return self.headlineHeavy
        case .headlineLight  :
            return self.headlineLight
        case .titleHeavy     :
            return self.titleHeavy
        case .titleLight     :
            return self.titleLight
        case .subheaderHeavy :
            return self.subheaderHeavy
        case .subheaderLight :
            return self.subheaderLight
        case .bodyHeavy      :
            return self.bodyHeavy
        case .bodyLight      :
            return self.bodyLight
        case .captionHeavy   :
            return self.captionHeavy
        case .captionLight   :
            return self.captionLight
        case .smallHeavy     :
            return self.smallHeavy
        case .smallLight     :
            return self.smallLight
        }// end switch case
    }// end public func get type face by key
}// end public struct OSCAFontSettings
