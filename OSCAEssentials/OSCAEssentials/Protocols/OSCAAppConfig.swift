//
//  OSCAAppConfig.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 30.08.22.
//

import Foundation

public protocol OSCAAppConfig {
  var defaultGeoPoint: (latitude: Double, longitude: Double) { get }
  // MARK: - Parse backend
  var parseAPIKey: String { get }
  var parseAPIKeyDev: String { get }
  var parseAPIBaseURL: String { get }
  var parseAPIBaseURLDev: String { get }
  var parseApplicationID: String { get }
  var parseApplicationIDDev: String { get }
  // MARK: - Info.plist data
  var infoPlistsData: Data { get }
  // MARK: - Device
  var deviceUUID: String { get }
  // MARK: - Deeplink
  var deeplinkScheme: String { get }
}// end public protocol OSCAAppConfig


