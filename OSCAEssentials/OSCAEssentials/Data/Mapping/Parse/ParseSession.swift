//
//  ParseSession.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 14.06.22.
//

import Foundation

/// ```json
/// {
///   "objectId":"8RKP1PidNv",
///   "sessionToken":"r:11e3c924cd3f36e3e509172cc76d19d7",
///   "user":{
///     "__type":"Pointer",
///     "className":"_User",
///     "objectId":"dCXzj8OShZ"
///   },
///   "createdWith":{"action":"login","authProvider":"anonymous"},
///   "expiresAt":{"__type":"Date","iso":"2022-09-12T14:15:43.010Z"},
///   "installationId":"testviacli",
///   "createdAt":"2022-06-14T14:15:43.010Z",
///   "updatedAt":"2022-06-14T14:15:43.010Z"
///  }
/// ```
public struct ParseSession {
  public struct LoginAction {
    public var action: String?
    public var authProvider: String?
  }// end public struct LoginAction
  
  public var objectId: String?
  
  public var createdAt: Date?
  
  public var updatedAt: Date?
  
  public var createdWith: LoginAction?
  
  public var sessionToken: String?
  
  public var userPointer: ParsePointer?
  
  public var parseUser: ParseUser?
  
  public var installationId: String?
  
  private enum CodingKeys: String, CodingKey {
    case userPointer = "user"
    case objectId
    case createdAt
    case updatedAt
    case createdWith
    case sessionToken
    case parseUser
    case installationId
  }// end private enum CodingKeys
}// end public struct ParseSession

extension ParseSession: OSCAParseClassObject {
}// end extension public struct ParseSession

// MARK: - initializers and mutators
extension ParseSession {
  public init(
    user: ParseUser,
    installationId: String
  ){
    self.parseUser = user
    self.installationId = installationId
  }// end public init
}// end extension public struct ParseSession

extension ParseSession.LoginAction: Codable {}
extension ParseSession.LoginAction: Equatable {}
extension ParseSession.LoginAction: Hashable {}

extension ParseSession {
  /// Parse class name
  public static var parseClassName : String { return "Session" }
}// end extension OSCAContactFormData
