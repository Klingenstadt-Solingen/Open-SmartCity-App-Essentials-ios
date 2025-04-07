//
//  UIDevice+OSCADeviceInfo.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 17.06.22.
//

import UIKit

public extension UIDevice {
  static var deviceInfo: OSCADeviceInfo {
    let device = UIDevice.current
    guard let uuid: String = device.identifierForVendor?.uuidString
    else {
      return OSCADeviceInfo(name: device.name,
                            systemName: device.systemName,
                            systemVersion: device.systemVersion,
                            model: device.model,
                            localizedModel: device.localizedModel)
    }// end guard
    return OSCADeviceInfo(
      name: device.name,
      systemName: device.systemName,
      systemVersion: device.systemVersion,
      model: device.model,
      localizedModel: device.localizedModel,
      uuid: uuid
    )// end return
  }// end static var deviceinfo: OSCADeviceInfo
}// extension class UIDevice
