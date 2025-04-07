//
//  ParseAuthData.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 14.06.22.
//

import Foundation

/// ```json
/// {
///   "authData":{
///     "anonymous":{
///       "id":"TestViaCLI"
///     }
///   }
/// }
/// ```
public struct ParseAuthData {
  public var authData: ParseAuthData.AuthData?

  public init(uuid: String) {
    let anonymous: ParseAuthData.AuthData.ID = ParseAuthData.AuthData.ID(id: uuid)
    authData = ParseAuthData.AuthData(anonymous: anonymous)
  } // end public init with uuid
} // public struct ParseAuthData

extension ParseAuthData {
  public struct AuthData {
    /// UUID for anonymouse authentication on `Parse` backend
    public var anonymous: ParseAuthData.AuthData.ID
    
    public init(anonymous: ParseAuthData.AuthData.ID) {
      self.anonymous = anonymous
    }// end public init
  } // end public struct AuthData
}// end extension public struct ParseAuthData

extension ParseAuthData.AuthData {
  public struct ID {
    public var id: String?
    
    public init(id: String? = nil) {
      self.id = id
    }// end public init
  } // end public struct ParseAuthData.AuthData.ID
}// end extension public struct AuthData

extension ParseAuthData: Codable {}
extension ParseAuthData: Hashable {}
extension ParseAuthData: Equatable {}

extension ParseAuthData.AuthData: Codable {}
extension ParseAuthData.AuthData: Hashable {}
extension ParseAuthData.AuthData: Equatable {}

extension ParseAuthData.AuthData.ID: Codable {}
extension ParseAuthData.AuthData.ID: Hashable {}
extension ParseAuthData.AuthData.ID: Equatable {}
