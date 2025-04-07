//
//  Array+Mapping.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 24.02.22.
//

import Foundation
public extension Array where Element: OSCAParseClassObject {
    /// returns all indices of `Array`'s elements where their `objectId` equals `value.objectId
    ///
    /// `Element`conforms to `OSCAParseClassObject`
    /// - Parameters value: the event
    /// - Returns: list of indices
    func allIndex(of value: Element) -> [Index]? {
        let indices = try? indices.filter { filterIndex in
            guard let valueObjectId = value.objectId else { throw OSCAParseError.noObjectID }
           guard let filterEventObjectId = self[filterIndex].objectId else { return false }
           return filterEventObjectId == valueObjectId
        }
        return indices
    }// end func allIndex
}// end extension struct Array
