//
//  OSCADeeplinkHandeble.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 12.07.22.
//

import Foundation

/// [see deeplinking](https://benoitpasquier.com/deep-linking-url-scheme-ios/)
public protocol OSCADeeplinkHandeble {
  func canOpenURL(_ url: URL) -> Bool
  func openURL(_ url: URL,
               onDismissed: (() -> Void)?) throws -> Void
}// end public protocol OSCADeeplinkHandeble
