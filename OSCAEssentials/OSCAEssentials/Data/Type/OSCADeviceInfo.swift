//
//  OSCADeviceInfo.swift
//  
//
//  Created by Stephan Breidenbach on 17.06.22.
//

import Foundation

public struct OSCADeviceInfo{
  public enum Keys: String {
    case userDefaults = "de.osca.essentials.deviceinfo"
  }// end public enum OSCADeviceInfo.Keys
  /// The name of the device.
  public var name: String?
  /// The current version of the operating system.
  public var systemName: String?
  /// The current version of the operating system.
  public var systemVersion: String?
  /// The model of the device
  public var model: String?
  /// The model of the device as a localized string.
  public var localizedModel: String?
  /// An alphanumeric string that uniquely identifies a device to the app’s vendor.
  public var uuid: String?
  /// The Parse mBaaS Installation object of the device
  public var parseInstallation: ParseInstallation?
  /// The Parse mBaaS User object of the device
  public var parseUser: ParseUser?
  /// The PArse mBaaS Session object of the device
  public var parseSession: ParseSession?
}// end public struct OSCADeviceInfo

// MARK: - public inits and mutators
extension OSCADeviceInfo{
  public init(
    name: String,
    systemName: String,
    systemVersion: String,
    model: String,
    localizedModel: String,
    uuid: String? = nil,
    parseInstallation: ParseInstallation? = nil,
    parseUser: ParseUser? = nil,
    parseSession: ParseSession? = nil
  ){
    self.name = name
    self.systemName = systemName
    self.systemVersion = systemVersion
    self.model = model
    self.localizedModel = localizedModel
    self.uuid = uuid
    self.parseInstallation = parseInstallation
    self.parseUser = parseUser
    self.parseSession = parseSession
  }// end public init
}// end extension public struct OSCADeviceInfo

extension OSCADeviceInfo: Codable {}

extension OSCADeviceInfo: Equatable {}

extension OSCADeviceInfo: Hashable {}

extension OSCADeviceInfo {
//  public static retrieve( from userDefaults: UserDefaults) throws -> OSCADeviceInfo {
//    return try userDefaults.getObject(forKey: <#T##String#>, castTo: <#T##Decodable.Protocol#>)
//  }// end public static retrieve
}// end extension public struct OSCADeviceInfo
