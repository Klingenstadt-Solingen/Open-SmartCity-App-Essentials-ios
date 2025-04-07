//
//  UseCase.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.04.21.
//
import Foundation

public protocol UseCase {
    @discardableResult
    func start() -> Cancelable?
}// end protocol UseCase
