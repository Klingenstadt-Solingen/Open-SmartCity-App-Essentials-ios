//
//  Error.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 17.01.22.
//
import Foundation 
/**
 extends the Error protocol
 */
public extension Swift.Error {
  var isInternetConnectionError: Bool {
    guard let error = self as? ConnectionError, error.isInternetConnectionError else {
      return false
    }
    return true
  }// end isInternetConnectionError
}// end extension protocol Swift.Error

public extension Swift.Error {
  /// [based upon](https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/)
  func resolveCategory() -> ErrorCategory {
    guard let categorized = self as? CategorizedError else {
      return ErrorCategory.nonRetryable
    }// end guard
    return categorized.category
  }// end func resolveCategory
}// end extension protocol Swift.Error
