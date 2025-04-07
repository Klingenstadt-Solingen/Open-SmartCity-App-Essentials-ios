//
//  Date+Arithmetic.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 09.06.22.
//

import Foundation
import SwiftDate

public extension Optional where Wrapped == Date {
  func add(seconds: Int) -> Date? {
    guard let date = self,
          let dateAdded = date.dateBySet([.second: seconds])
    else { return nil }
    return dateAdded
  }// end func add
}// end public extension Optional where Wrapped == Date

