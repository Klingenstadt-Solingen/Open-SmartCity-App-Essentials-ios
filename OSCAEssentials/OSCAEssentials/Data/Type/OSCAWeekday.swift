//
//  OSCAWeekday.swift
//  OSCAEssentials
//
//  Created by Ömer Kurutay on 02.08.22.
//

import Foundation

public enum OSCAWeekday: Int {
  case monday = 1
  case tuesday = 2
  case wednesday = 3
  case thursday = 4
  case friday = 5
  case saturday = 6
  case sunday = 0
  
  public func weekdaySymbol() -> String {
    return Calendar.current.weekdaySymbols[self.rawValue]
  }
}
