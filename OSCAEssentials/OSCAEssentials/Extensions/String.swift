//
//  String.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 05.11.21.
//

import Foundation

/// A Unicode string value that is a collection of characters.
public extension String {
  // swiftlint: disable identifier_name
    /// Cut a string out of a string
    /// - Parameters:
    ///   - from: the start string
    ///   - to: the end string
    /// - Returns: returns a string between the parameters
    func slice(from: String, to: String) -> String? {
        (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom ..< endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom ..< substringTo])
            }
        }
    }// end func slice
  // swiftlint: enable identifier_name
}// end extension struct String

/**
 [see at](https://www.hackingwithswift.com/example-code/strings/how-to-capitalize-the-first-letter-of-a-string)
 */
public extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }// end func capitalizingFirstLetter

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }// end mutating func capitalizeFirstLetter
}// end extension struct String

public extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }// end func isValidEmail
}// end public extension String

public extension String {
  func convertToPhoneNumber(pattern: String? = nil, options: NSRegularExpression.Options = .caseInsensitive) -> String? {
    let regex: NSRegularExpression?
    
    if let pattern = pattern {
      regex = try? NSRegularExpression(pattern: pattern,
                                       options: options)
      
    } else {
      regex = try? NSRegularExpression(
        pattern: "(\\s)?(\\/)?(-)?(\\()?(\\))?",
        options: options)
    }
    
    guard let regex = regex else { return nil }
    return regex.stringByReplacingMatches(
      in: self,
      options: [],
      range: NSRange(location: 0, length: self.count),
      withTemplate: "")
  }
}
