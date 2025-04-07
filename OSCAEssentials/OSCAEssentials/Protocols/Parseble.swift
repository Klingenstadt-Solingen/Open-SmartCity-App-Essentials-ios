//
//  Parseble.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.09.22.
//

import Foundation
/// [Deeplink & Push](https://www.bam.tech/article/organizing-your-app-to-handle-deeplinks-and-push-notifications)
public protocol Parseble {
  associatedtype InputType
  
  /// Parse the `content` into a `Payload`.
  /// If the `content` is missing some required elements, the function returns nil.
  /// - Returns: An instance of `Payload` or nil if the `content` can't be parsed.
  func parse(content: InputType) -> Payload?
}// end protocol Parseble
