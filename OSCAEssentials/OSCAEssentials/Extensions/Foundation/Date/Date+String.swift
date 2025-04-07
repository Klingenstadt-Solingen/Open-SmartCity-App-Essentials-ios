//
//  Date#String.swift
//  OSCAEssentials
//
//  Created by Mammut Nithammer on 20.01.22.
//  Reviewed by Stephan Breidenbach on 07.06.22.
//

import Foundation

public extension Date {
  /// Converts a date to a string with `dd.MM.yy` format.
  var toString: String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yy"
    dateFormatter.timeZone = TimeZone.current
    
    return dateFormatter.string(from: self)
  }// end var toString
  
  /// converts a `Foundation.Date` object into an iso `String`
  ///
  /// - Parameter date: `Foundation.Date` object
  static func ISOStringFromDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    return dateFormatter.string(from: date).appending("Z")
  }// end static func ISOStringFromDate
  
  static func dateFromISOString(string: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    dateFormatter.dateFormat = string.contains(".")
    ? "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    : "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.date(from: string)
  }// end static func dateFromISOString
  
  func toLocalTime() -> Date {
    let timezone = TimeZone.current
    let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
    return Date(timeInterval: seconds, since: self)
  }
}// end public extension Foundation.Date
