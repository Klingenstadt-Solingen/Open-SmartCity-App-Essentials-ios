//
//  ConnectionError.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 01.10.21.
//  based upon Oleh Kudinov
//
import Foundation
/**
 connection error protocol that conforms to Error
 */
public protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}// end protocol ConnectionError
