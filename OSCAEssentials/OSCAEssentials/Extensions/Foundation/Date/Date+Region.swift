//
//  Date+Region.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 09.06.22.
//

import Foundation
import SwiftDate

/// [optional Date extension](https://stackoverflow.com/questions/29462953/how-to-add-an-optional-string-extension)
public extension Optional where Wrapped == Date {
  /// formats an optional `Foundation.Date` in a local timezone
  /// - Returns: formatted time `String`
  func localFormatTime(custom format: String? = nil) -> String {
    guard let date = self
    else { return "---" }
    // localize date
    let localDate = date.convertTo(region: Region.current)
    
    if let format = format {
      return localDate.toFormat(format)
    } else {
      // convert to time string
      if localDate.isToday {
        // today
        return localDate.toFormat("HH:mm")
      } else if localDate.isTomorrow {
        // tomorrow
        let tomorrow: String = NSLocalizedString(
          "tomorrow",
          bundle: OSCAEssentials.bundle,
          comment: "Show text for tomorrow")
        return localDate.toFormat("'\(tomorrow)' HH:mm")
      } else {
        // else
        return localDate.toFormat("dd.MM. HH:mm")
      }// end if
    }
  }// end func localFormatTime
  
}// end public extension optional Foundation.Date
