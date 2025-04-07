//
//  OSCAParsePersistentStorage.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 24.02.22.
//

import Foundation

public enum OSCAParsePersistentStorage {
    /// static mutating function for adding an element conforming to `OSCAParseClassObject` to a `list`of such elements.
    /// This function conforms to the obligations:
    /// 1) The list contains only one single element per each `objectId`
    /// 2) The list contains only elements with the latest `createdAt` per each `objectId`
    /// 3) The list contains only elements with the latest `updatedAt` per each `objectId
    /// - Parameter element: the object conforming to `OSCAParseClassObject` that needs to be added to the `list`
    /// - Parameter list: list of elements (`inout`)
    public static func add<T: OSCAParseClassObject>(_ element: T, in list: inout [T]) -> Void {
        var compare = element
        guard var compareCreatedAt = compare.createdAt,
              var compareUpdatedAt = compare.updatedAt else { return }
        // are there elements in all elements, which `objectId` equals that of the element?
        if let findIndicies = list.allIndex(of: compare) {
            for elementIndex in findIndicies {
                let elementAtIndex = list[elementIndex]
                guard let elementAtIndexCreatedAt = elementAtIndex.createdAt,
                      let elementAtIndexUpdatedAt = elementAtIndex.updatedAt else {
                          list.remove(at: elementIndex)
                          continue
                      }// end guard
                // the compared element is older than the element at index
                if compareCreatedAt < elementAtIndexCreatedAt {
                    // swap elements
                    compare = list.remove(at: elementIndex)
                    compareCreatedAt = elementAtIndexCreatedAt
                    compareUpdatedAt = elementAtIndexUpdatedAt
                    continue
                }// end if
                // the compared element was created at the same time than the element at index
                if compareCreatedAt == elementAtIndexCreatedAt {
                    // the compared element update is older than the element at index update
                    if compareUpdatedAt < elementAtIndexUpdatedAt {
                        // swap elements
                        compare = list.remove(at: elementIndex)
                        compareCreatedAt = elementAtIndexCreatedAt
                        compareUpdatedAt = elementAtIndexUpdatedAt
                        continue
                    }// end if
                    // the compared element was updated at the same time than the element at index
                    if compareUpdatedAt == elementAtIndexUpdatedAt {
                        // remove element at index
                        list.remove(at: elementIndex)
                        continue
                    }// end if
                    // the compared element update is newer than the element at index update
                    if compareUpdatedAt > elementAtIndexUpdatedAt {
                        // remove element at index
                        list.remove(at: elementIndex)
                        continue
                    }// end if
                }// end if
                // the compared element is newer than the element at index
                if compareCreatedAt > elementAtIndexCreatedAt {
                    // remove element at index
                    list.remove(at: elementIndex)
                    continue
                }// end if
            }// end for elementIndex
        }// end if
        list.append(compare)
    }// end private func add
}// end public enum OSCAParsePersistentStorage
