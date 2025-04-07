//
//  UILabel.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 05.11.21.
//
import UIKit

/// A view that displays one or more lines of read-only text, often used in conjunction with controls to describe their intended purpose.
public extension UILabel {
    /// Sets html content to a UILabel
    /// - Parameter htmlText: String with html content
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format: "<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(font.pointSize); color: \(textColor.toHexString())\">%@</span>", htmlText)

        guard let data = modifiedFont.data(using: .unicode, allowLossyConversion: true) else { return }

        let attrStr = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil
        )// end let attrStr

        attributedText = attrStr
    }// end func setHTMLFromString

    /// Styles all urls as hyperlinks
    /// - Parameters:
    ///   - text: The text for the label
    ///   - links: An array of urls
    ///   - color: The text color
    func setTextWithLinks(text: String, links: [String], color: UIColor) {
        let underlineAttriString = NSMutableAttributedString(string: text)

        for link in links {
            let range = (text as NSString).range(of: link)
            underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            underlineAttriString.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range)
            underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }// end for link in links

        attributedText = underlineAttriString
        sizeToFit()
    }// end func setTextWithLinks

    /// Hyphernating for a UILabel
    /// - Parameter alignment: Text alignment
    func hyphenate(alignment: NSTextAlignment = .center) {
        guard var attributedText = attributedText else {
            assertionFailure("attributedText is nil")
            return
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        let attstr = NSMutableAttributedString(attributedString: attributedText)
        paragraphStyle.hyphenationFactor = 1.0
        attstr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(0 ..< attstr.length))
        self.attributedText = attstr
    }// end func hyphenate
  
  func with(_ attachment: UIImage) {
    let image = attachment.withRenderingMode(.alwaysOriginal)
    let attachment = NSTextAttachment(image: image)
    attributedText = NSAttributedString(attachment: attachment)
  }
  
  enum ContentAlignment { case horizontal, vertical }
  
  func with(text: String, alignment: ContentAlignment = .horizontal, lineSpacing: CGFloat = 0.0, attachments: [UIImage], attachmentBeforeText: Bool = true) {
    let combinedAttachments = NSMutableAttributedString(string: "")
    
    for (index, attachment) in attachments.enumerated() {
      let textAttachment = NSTextAttachment(image: attachment)
      let attrString = NSMutableAttributedString(attachment: textAttachment)
      
      combinedAttachments.append(attrString)
      if index < attachments.count - 1, alignment == .vertical {
        combinedAttachments.append(NSAttributedString(string: "\n"))
      }
    }
    
    let textWithAttachment = attachmentBeforeText
      ? NSMutableAttributedString(attributedString: combinedAttachments)
      : NSMutableAttributedString(string: text)
    let secondItem = attachmentBeforeText
      ? NSAttributedString(string: text)
      : combinedAttachments
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    paragraphStyle.alignment = .center
    
    textWithAttachment.append(secondItem)
    textWithAttachment.addAttribute(
      .paragraphStyle,
      value: paragraphStyle,
      range: NSRange(location: 0,
                     length: textWithAttachment.length))
    
    self.attributedText = textWithAttachment
  }
}// end extension class UILabel
