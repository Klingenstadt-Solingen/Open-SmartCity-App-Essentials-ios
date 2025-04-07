//
//  DeeplinkParser.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.09.22.
//

import Foundation
public class DeeplinkParser: Parseble {
  public func parse(content: URL) -> Payload? {
    return content.toPayload
  }// end public func parse
  
  public init() {}
}// end class DeeplinkParser
