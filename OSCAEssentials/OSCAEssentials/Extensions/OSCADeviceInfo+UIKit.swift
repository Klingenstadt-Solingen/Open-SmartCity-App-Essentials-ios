//
//  OSCADeviceInfo+UIKit.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 04.07.22.
//

import UIKit

public extension OSCADeviceInfo {
  /// initializes an `OSCADeviceInfo`object with data from `UIDevice.current`
  init(parseInstallation: ParseInstallation? = nil,
       parseUser: ParseUser? = nil,
       parseSession: ParseSession? = nil
  ) {
    let current = UIDevice.current
    self.name = current.name
    self.systemName = current.systemName
    self.systemVersion = current.systemVersion
    self.model = current.model
    self.localizedModel = current.localizedModel
    self.uuid = current.identifierForVendor?.uuidString
    self.parseInstallation = parseInstallation
    self.parseUser = parseUser
  }// end init
}// end public extension OSCADeviceInfo
