//
//  ParseDate.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 09.02.22.
//  Reviewed by Stephan Breidenbach on 14.06.22
//

import Foundation

// MARK: - ParseDate
/**
 [Date ISO Formatter](https://gist.github.com/alexpaul/58d068bcc9c11b2a66954ff0cea87587)
 */
public struct ParseDate: Encodable, Hashable {
  private let type: String?
  private let timeStampISO: String?
  
  public enum CodingKeys: String, CodingKey {
    case type = "__type"
    case timeStampISO = "iso"
  }// end private enum CodingKeys
  /**
   "2021-10-01T11:32:04.700Z"
   */
  public var dateISO8601: Date? {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [ .withInternetDateTime,
                                .withDashSeparatorInDate,
                                .withFullDate,
                                .withFractionalSeconds,
                                .withColonSeparatorInTimeZone ]
    guard let isoString: String = self.timeStampISO,
          let date: Date = formatter.date(from: isoString) else { return nil }
    return date
  }// end public var dateISO8601: Date?
  
  public var timeStampISO8601: String? {
    return self.timeStampISO
  }// end
}// end public struct ParseDate

// MARK: - ParseDate Equatable conformance
extension ParseDate: Equatable {
  // swiftlint: disable operator_whitespace
  public static func ==(lhs:ParseDate, rhs:ParseDate) -> Bool{
    let typeEquals: Bool = lhs.type == rhs.type
    let timeStampISOEquals: Bool = lhs.timeStampISO == rhs.timeStampISO
    return typeEquals && timeStampISOEquals
  }// end public static func ==
  // swiftlint: enable operator_whitespace
}// end extension struct ParseDate: Equatable

// MARK: - initializers
extension ParseDate {
  public init(date: Date) {
    self.init(timeStampISO: Date.ISOStringFromDate(date: date))!
  }// end public int with Date
  
  public init?(timeStampISO: String?){
    guard let timeStamp: String = timeStampISO else { return nil }
    self.type = "Date"
    self.timeStampISO = timeStamp
  }// end public init wit timeStamp
}// end extension ParseDate

extension ParseDate: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: ParseDate.CodingKeys.self)
    self.type = try container.decode(String.self, forKey: .type)
    self.timeStampISO = try container.decode(String.self, forKey: .timeStampISO)
  }// end public init from decoder
}// end extension public struct ParseDate

extension ParseDate {
  public init(_ value: ParseDate) {
    self.init(type: value.type,
              timeStampISO: value.timeStampISO)
  }// end copy constructor
}// end extension public struct ParseDate
