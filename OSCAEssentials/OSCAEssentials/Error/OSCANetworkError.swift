//
//  OSCANetworkError.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 31.01.23.
//

import Foundation

/// Defines the Network service errors.
public enum OSCANetworkError: Swift.Error {
  case invalidRequest
  case invalidResponse
  case dataLoadingError(statusCode: Int, data: Data)
  case jsonDecodingError(error: Error)
  case isInternetConnectionError
}// end enum OSCANetworkError: Error
