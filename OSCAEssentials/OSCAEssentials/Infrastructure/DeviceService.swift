//
//  DeviceService.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 03.02.22.
//

import Foundation
import DeviceKit

public enum DeviceService {
    /**
     - Returns "Betriebssystem: iOS <system version> \n\n Hardware: <hardware description>
     */
    public static func getDeviceInfo() -> String {
        return "</br></br>Betriebssystem: iOS \(Device.current.systemVersion ?? "")</br>Hardware: \(Device.current.safeDescription)"
    }// end static func getDevideInfo
}// end public final class Device
