//
//  OSCAObjectSavableError.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 20.06.22.
//

import Foundation

public enum OSCAObjectSavableError: String, LocalizedError {
  case unableToEncode = "Unable to encode object into data"
  case noValue = "No data object found for the given key"
  case unableToDecode = "Unable to decode object into given type"
  case noValidUserDefaults = "No valid user defaults instance"
  
  public var errorDescription: String? {
    rawValue
  }// end var errorDescription
}// end enum OSCAObjectSavableError
