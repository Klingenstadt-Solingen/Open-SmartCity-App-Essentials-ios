//
//  ParseUser.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 14.06.22.
//

import Foundation

/// ```json
///  {
///    "objectId":"dCXzj8OShZ",
///    "username":"P0PSs3hpCahxlU8W7iJoDHyKO",
///    "authData":{"anonymous":{"id":"TestViaCLI"}},
///    "createdAt":"2022-06-14T09:07:10.952Z",
///    "updatedAt":"2022-06-14T09:07:10.952Z",
///    "ACL":{"dCXzj8OShZ":{"read":true,"write":true}},
///    "sessionToken":"r:11e3c924cd3f36e3e509172cc76d19d7"
///  }
///  ```
public struct ParseUser: OSCAParseClassObject {
  /// object identifier
  public var objectId: String?
  /// object's creation
  public var createdAt: Date?
  /// object's update
  public var updatedAt: Date?
  /// user name
  public var username: String?
  /// session token
  public var sessionToken: String?
  /// parse auth data
  public var authData: ParseAuthData.AuthData?
  
  public var firstname: String?
  public var lastname: String?

  public init(authData: ParseAuthData.AuthData?) {
    self.authData = authData
  }
} // end public struct ParseUser

extension ParseUser {
  /// Parse class name
  public static var parseClassName : String { return "User" }
}// end extension OSCAContactFormData

public extension ParseUser {
  /// UserDefaults object keys
  enum UserDefaultKeys: String {
    case userDefaultsParseUserObject = "ParseUser_ParseUserObject"
  }
}
