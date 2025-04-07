import Foundation

public struct OSCAPointOfInterestDetail: Codable, Hashable {
    public var type: OSCAPointOfInterestDetailType
    
    public var title: String
    public var subtitle: String?
    
    public var value: String?
    
    public var iconName: String?
    public var iconPath: String?
    public var iconMimetype: String?
    
    public var symbolName: String?
    public var symbolPath: String?
    public var symbolMimetype: String?
    
    public var position: Int
    
    public var filterField: String?
    
    public func getImageUrl() -> URL? {
        if let symbolPath = symbolPath, let symbolName = symbolName, let symbolMimetype = symbolMimetype {
            return URL(string: "\(symbolPath)/\(symbolName)\(symbolMimetype)")
        }
        return nil
    }
    
    public func getIconImageUrl() -> URL? {
        if let iconPath = iconPath, let iconName = iconName, let iconMimetype = iconMimetype {
            return URL(string: "\(iconPath)/\(iconName)\(iconMimetype)")
        }
        return nil
    }
}

public enum OSCAPointOfInterestDetailType: String, Codable {
    case text
    case tel
    case url
    case mail
    case position
    case list
    case html
}
