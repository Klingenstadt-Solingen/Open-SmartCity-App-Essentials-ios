//
//  ParseInstallation.swift
//
//
//  Created by Stephan Breidenbach on 17.06.22.
//

import Foundation

/// ```json
/// {
///  "objectId":"ePN4655ap0",
///  "installationId":"3ecc969d-5f92-4e82-9d93-e5d8f8961651",
///  "localeIdentifier":"de-DE",
///  "badge":0,
///  "parseVersion":"1.19.2",
///  "appIdentifier":"de.solingen.app",
///  "appName":"Solingen",
///  "deviceType":"ios",
///  "appVersion":"20210910.1",
///  "timeZone":"Europe/Berlin",
///  "openCount":1,
///  "deviceModel":"iPhone 12",
///  "osVersion":"15.4.1",
///  "osType":"iOS",
///  "createdAt":"2022-06-17T06:33:39.638Z",
///  "updatedAt":"2022-06-17T06:33:39.638Z"
/// }
/// ```
public struct ParseInstallation: OSCAParseClassObject {
  /// The type of device, “ios”, “android”, “winrt”, “winphone”, or “dotnet”.
  public enum DeviceType: String {
    case ios
    case android
    case winrt
    case winphone
    case dotnet
  } // end public enum ParseInstallation.DeviceType
  /// object identifier
  public var objectId: String?
  /// object's creation
  public var createdAt: Date?
  /// object's update
  public var updatedAt: Date?
  /// is a number field representing the last known application badge for iOS installations.
  public var badge: Int?
  ///  An array of the channels to which a device is currently subscribed.
  public var channels: [String]?
  ///  The current time zone where the target device is located. This should be an IANA time zone identifier.
  public var timeZone: String?
  ///  The type of device, “ios”, “android”, “winrt”, “winphone”, or “dotnet”(readonly).
  public var deviceType: ParseInstallation.DeviceType?
  /// This field is reserved for directing Parse to the push delivery network to be used. If the device is registered to receive pushes via FCM, this field will be marked “gcm”. If this device is not using FCM, and is using Parse’s push notification service, it will be blank (readonly).
  public var pushType: String?
  /// Universally Unique Identifier (UUID) for the device used by Parse. It must be unique across all of an app’s installations. (readonly).
  public var installationId: String?
  /// The Apple or Google generated token used to deliver messages to the APNs or FCM push networks respectively.
  public var deviceToken: String?
  ///  The Microsoft-generated push URIs for Windows devices.
  public var channelUris: String?
  /// The display name of the client application to which this installation belongs.
  public var appName: String?
  /// The version string of the client application to which this installation belongs.
  public var appVersion: String?
  /// The version of the Parse SDK which this installation uses.
  public var parseVersion: String?
  /// A unique identifier for this installation’s client application. In iOS, this is the Bundle Identifier.
  public var appIdentifier: String?
  ///
  public var localeIdentifier: String?
  ///
  public var openCount: Int?
  ///
  public var deviceModel: String?
  ///
  public var osVersion: String?
  ///
  public var osType: String?
} // end public struct ParseInstallation

extension ParseInstallation.DeviceType: Codable {}

extension ParseInstallation.DeviceType: Hashable {}

// MARK: - initializers and mutators

extension ParseInstallation {
  public init(objectId: String? = nil,
              createdAt: Date? = nil,
              updatedAt: Date? = nil,
              deviceType: ParseInstallation.DeviceType = .ios
  ) {
    self.objectId = objectId
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.deviceType = deviceType
  } // end public init

  public init(deviceType: ParseInstallation.DeviceType = .ios, installationId: String) {
    self.deviceType = deviceType
    self.installationId = installationId
  } // end public init
} // end extension public struct ParseInstallation

extension ParseInstallation {
  /// Parse class name
  public static var parseClassName : String { return "Installation" }
}// end extension OSCAContactFormData
