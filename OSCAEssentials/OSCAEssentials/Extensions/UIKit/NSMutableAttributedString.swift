//
//  NSMutableAttributedString.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 05.11.21.
//

import UIKit

/// A mutable string object that also contains attributes (such as visual style, hyperlinks, or accessibility data) associated with various portions of its text content.
public extension NSMutableAttributedString {
    // MARK: - Init & dealloc methods

    /// Function to convert HTML String into a NSMutableAttributedString
    /// - Parameters:
    ///   - html: Sting with HTML content
    ///   - font: UIFont for formatting the returning String
    /// - Throws: throws if error occours
    convenience init?(HTMLString html: String, font: UIFont? = nil, color: UIColor = .black) throws {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] =
            [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
            ]

        guard let data = html.data(using: .utf8, allowLossyConversion: true) else {
            throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
        }

        guard let attr = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
            throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
        }

        if let font = font {
            var attrs = attr.attributes(at: 0, effectiveRange: nil)
            attrs[NSAttributedString.Key.font] = font
            attrs[NSAttributedString.Key.foregroundColor] = color
            attr.setAttributes(attrs, range: NSRange(location: 0, length: attr.length))
            self.init(attributedString: attr)
        } else {
            attr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: attr.length))
            self.init(attributedString: attr)
        }// end if
    }// end convenience init
}// end extension class NSMutableAttributedString

