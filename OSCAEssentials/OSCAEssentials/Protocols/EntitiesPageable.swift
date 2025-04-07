//
//  EntitiesPageable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 04.10.21.
//
import Foundation


// [protocol associated types](https://www.hackingwithswift.com/articles/74/understanding-protocol-associated-types-and-their-constraints)
public protocol EntitiesPageable: Equatable {
    associatedtype EntityType: Entity
    var page: Int { get set }
    var totalPages: Int { get set }
    var entities: [EntityType] { get set }
    
    init()
    init(page: Int, totalPages: Int, entities: [EntityType] )
}// end public protocol ListPage

extension EntitiesPageable {
    // now you can provide a default implementation
    init(page: Int, totalPages: Int, entities: [EntityType]) {
        self.init()
        self.page = page
        self.totalPages = totalPages
        self.entities = entities
    }// end
}// end extension protocol EntitiesPageable// now you can provide a default implementation

