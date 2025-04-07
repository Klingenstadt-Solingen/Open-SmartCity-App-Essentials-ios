//
//  OSCAParseError.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 24.02.22.
//

import Foundation

public enum OSCAParseError: Swift.Error, CustomStringConvertible {
    case noObjectID
    case noCreatedAt
    case noUpdatedAt
    
    public var description: String {
        switch self {
        case .noObjectID:
            return "There is no ID in the object!"
        case .noCreatedAt:
            return "There is no object creation time!"
        case .noUpdatedAt:
            return "There is no object changed time!"
        }// end switch case
    }// end public var description
}// end public enum ParseError
