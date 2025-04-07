//
//  URL+Payload.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 07.09.22.
//

import Foundation

public extension URL {
  var toPayload: Payload? {
    guard !self.pathComponents.isEmpty,
          self.pathComponents.count > 1
    else { return nil }
    let target = self.pathComponents[1]
    var parameters = [String: String]()
    
    URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems?.forEach { queryItem in
      parameters[queryItem.name] = queryItem.value
    }// end parse
    let payload = Payload(target: target, parameters: parameters)
    return payload
  }// end var toPayload
}// end public extension URL
