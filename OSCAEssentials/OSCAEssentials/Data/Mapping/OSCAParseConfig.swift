//
//  OSCAParseConfig.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 01.02.23.
//

import Foundation

public protocol OSCAParseConfig: Codable, Hashable, Equatable {
  var params: JSON? { get set }
  var masterKeyOnly: JSON? { get set }
  init(params: JSON?, masterKeyOnly: JSON?)
}// end public protocol OSCAParseConfig
