//
//  OSCAEssentials.swift
//  OSCAEssentials
//
//  Created by Mammut Nithammer on 17.01.22.
//  Reviewed by Stephan Breidenbach on 09.06.22
//
import Foundation
import SwiftDate

public struct OSCAEssentials: OSCAModule {
  public var version: String = "1.0.3"
  public var bundlePrefix: String = "de.osca.essentials"
  /// **available after module initialization only!!!**
  public internal(set) static var bundle: Bundle!
  public init() {
#if SWIFT_PACKAGE
    Self.bundle = Bundle.module
#else
    guard let bundle = Bundle(identifier: self.bundlePrefix) else { fatalError("Module bundle not initialized!") }
    Self.bundle = bundle
#endif
    // Default Region for SwiftDate
    let berlin = Region(calendar: Calendars.gregorian, zone: Zones.europeBerlin, locale: Locales.german)
    SwiftDate.defaultRegion = berlin
  }// end public init
}// end public stuct OSCAEssentials
