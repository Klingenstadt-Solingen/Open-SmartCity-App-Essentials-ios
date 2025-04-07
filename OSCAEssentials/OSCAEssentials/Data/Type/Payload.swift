//
//  Payload.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.09.22.
//

// swiftlint: disable empty_commented_line
import Foundation

public struct Payload {
  public let target: String
  public let parameters: [String: String]
}// end struct Payload

extension Payload: Codable {}
extension Payload: Hashable {}
extension Payload: Equatable {}

// swiftlint: disable comments_space
extension Payload {
  /// ```json
  /// {
  ///   "aps": {
  ///     "alert": {
  ///        //can be string or object
  ///        //alert object keys
  ///       "body": "string",
  ///       "title": "string",
  ///       "subtitle": "string",
  ///       "launch-image": "string",
  ///        // localization arguments
  ///       "title-loc-key": "string",
  ///       "title-loc-args": ["array", "of", "strings"],
  ///       "subtitle-loc-key": "string",
  ///       "subtitle-loc-args": ["array", "of", "strings"],
  ///       "loc-key": "string",
  ///       "loc-args": ["array", "of", "strings"]
  ///     },
  ///     // message options
  ///     "badge": 0, // number
  ///     "sound": "string or dictionary",
  ///     "thread-id": "string",
  ///     "category": "string",
  ///     "content-available": 0, // number, 0 (default) or 1
  ///     "mutable-content": 0, // number, 0 (default) or 1
  ///     "target-content-id": "string",
  ///   },
  /// // options supported by Customer.io's SDK
  ///   "OSCA": {
  ///     "push": {
  ///     "link": "string", // deep links in the format remote-habits://deep?message=hello&message2=world
  ///     "image": "string" // https URL to an image, including the file extension
  ///   }
  ///  },
  ///  // additional custom data
  ///  "additionalProperties": "custom keys"
  /// }
  /// ```
  public struct APN {
    public var aps: APS?
    public var osca: OSCA?
  }// end struct APN
}// end extension struct Payload
// swiftlint: enable comments_space

extension Payload.APN {
  private enum CodingKeys: String, CodingKey {
    case aps  = "aps"
    case osca = "OSCA"
  }// end private enum CodingKeys
}// end extension struct APN

extension Payload.APN: Codable {}
extension Payload.APN: Equatable {}
extension Payload.APN: Hashable {}

extension Payload.APN {
  public struct APS {
    public var alert               : Payload.APN.APS.Alert?
    public var badge               : Int?
    public var sound               : String?
    public var threadId            : String?
    public var category            : String?
    public var contentAvailable    : Bool?
    public var mutableContent      : Bool?
    public var targetContentId     : String?
  }// end public struct APS
}// end extension struct APN

extension Payload.APN.APS {
  private enum CodingKeys: String, CodingKey {
    case alert                                  //
    case badge                                  //
    case sound                                  //
    case threadId = "thread-id"                 //
    case category                               //
    case contentAvailable = "content-available" //
    case mutableContent = "mutable-content"     //
    case targetContentId = "target-content-id"  //
  }// end private enum CodingKeys
}// end extension public struct APS

extension Payload.APN.APS: Codable {}
extension Payload.APN.APS: Equatable {}
extension Payload.APN.APS: Hashable {}

extension Payload.APN.APS {
  public struct Alert {
    public var body              : String?                 //
    public var title             : String?                 //
    public var subtitle          : String?                 //
    public var launchImage       : String?                 //
    public var titleLocKey       : String?                 //
    public var titleLocArgs      : [String?]?              //
    public var subtitleLocKey    : String?                 //
    public var subtitleLocArgs   : [String?]?              //
    public var locKey            : String?                 //
    public var locArgs           : [String?]?              //
  }// end public struct Alert
}// end extension public struct APS

extension Payload.APN.APS.Alert {
  private enum CodingKeys: String, CodingKey {
    case body                                   //
    case title                                  //
    case subtitle                               //
    case launchImage       = "launch-image"     //
    case titleLocKey       = "title-loc-key"    //
    case titleLocArgs      = "title-loc-args"   //
    case subtitleLocKey    = "subtitle-loc-key" //
    case subtitleLocArgs   = "subtitle-loc-args"//
    case locKey            = "loc-key"          //
    case locArgs           = "loc-args"         //
  }// end private enum CodingKeys
}// end extension public struct Alert

extension Payload.APN.APS.Alert: Codable {}
extension Payload.APN.APS.Alert: Equatable {}
extension Payload.APN.APS.Alert: Hashable {}

extension Payload.APN {
  public struct OSCA {
    public var push: Payload.APN.OSCA.Push
  }// end public struct OSCA
}// end extension struct APN

extension Payload.APN.OSCA: Codable {}
extension Payload.APN.OSCA: Equatable {}
extension Payload.APN.OSCA: Hashable {}

extension Payload.APN.OSCA {
  public struct Push {
    public var image: String?  //
    public var link : URL?     //
  }// end public struct Push
}// end extension public struct OSCA

extension Payload.APN.OSCA.Push: Codable {}
extension Payload.APN.OSCA.Push: Equatable {}
extension Payload.APN.OSCA.Push: Hashable {}
// swiftlint: enable empty_commented_line
