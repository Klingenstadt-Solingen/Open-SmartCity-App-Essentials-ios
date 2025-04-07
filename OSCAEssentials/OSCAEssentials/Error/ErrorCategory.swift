//
//  ErrorCategory.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 19.10.22.
//

import Foundation

/// [based upon](https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/)
public enum ErrorCategory {
  case nonRetryable
  case retryable
}// end public enum ErrorCategory

public protocol CategorizedError: Swift.Error {
  var category: ErrorCategory { get }
}// end protocol CategorizedError
