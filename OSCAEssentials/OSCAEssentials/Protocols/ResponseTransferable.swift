//
//  ResponseTransferable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 04.10.21.
//
import Foundation

public protocol ResponsePageTransferable {
    associatedtype EntitiesPage: EntitiesPageable
    associatedtype Response: ResponseTransferable
    
    var page: Int { get }
    var totalPages: Int { get }
    var responses: [Response] { get }
    
    func toDomain() -> EntitiesPage
}// end public protocol ResponsePageTransferable

public protocol ResponsesTransferable: Codable, Equatable {
    associatedtype Response: ResponseTransferable
    associatedtype CodingKeys: RawRepresentable where CodingKeys.RawValue: StringProtocol
    var responses: [Response] { get }
    
}// end public protocol ResponsesTransferable

public protocol ResponseTransferable: Codable, Equatable {
    associatedtype EntityType: Entity
    associatedtype CodingKeys: RawRepresentable where CodingKeys.RawValue: StringProtocol
    func toDomain() -> EntityType
}// end public protocol ResponseTransferable

