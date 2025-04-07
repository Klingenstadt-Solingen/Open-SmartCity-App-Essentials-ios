//
//  UniqueIdentifier.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 01.10.21.
//
import Foundation
/**
 [create UUID](https://www.hackingwithswift.com/example-code/system/how-to-generate-a-random-identifier-using-uuid)
 */

public struct UniqueIdentifier {
    private let uuid: UUID
    
    public var uniqueIdentifierString: String {
        self.uuid.uuidString
    }// end public var uniqueIdentifierString
    
    /**
     public initializer for normal use
     */
    public init(){
        self.uuid = UUID()
    }// end public init
    
    /**
     internal initializer for testing purpose
     */
    internal init(uuid: UUID){
        self.uuid = uuid
    }// end internal init
}// end public struct
