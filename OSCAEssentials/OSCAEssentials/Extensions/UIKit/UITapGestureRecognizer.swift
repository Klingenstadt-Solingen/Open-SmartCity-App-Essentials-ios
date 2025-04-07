//
//  UITapGestureRecognizer.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 05.11.21.
//
import UIKit

/// A concrete subclass of UIGestureRecognizer that looks for single or multiple taps.
public extension UITapGestureRecognizer {
    /// Detects a tap gesture in a given range of text
    /// - Parameters:
    ///   - label: The UILabel containing the text
    ///   - targetRange: the range tha schould be monitored
    /// - Returns: returns true if the given range was tapped
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        guard let attributedText = label.attributedText else { return false }
        let textStorage = NSTextStorage(attributedString: attributedText)

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        let locationOfTouchInLabel = location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)

        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }// end func didTapAttributedTextInLabel
}// end extension class UITapGestureRecognizer
