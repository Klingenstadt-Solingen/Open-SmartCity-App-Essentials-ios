//
//  Date+Millis.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 01.03.22.
//

import Foundation

public extension Date {
  /// - Parameter milliseconds: amount of milliseconds since 01.01.1970
  init(milliseconds: Int64) {
    let seconds = Double(milliseconds) / 1000.0
    self = Date(timeIntervalSince1970: TimeInterval(seconds))
  }// end init
  
  var millisecondsSince1970: Int64 {
    Int64((self.timeIntervalSince1970 * 1000.0).rounded())
  }// end var millisecondsSince1970
  
  // swiftlint: disable operator_whitespace
  /// operator overloading for millis
  static func ==(lhs: Date, rhs: Date) -> Bool {
    return lhs.millisecondsSince1970 == rhs.millisecondsSince1970
  }// end static func ==
  // swiftlint: enable operator_whitespace
}// public extension Date
