//
//  OSCAUrlData.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 31.01.23.
//

import Foundation

public protocol OSCAUrlData: Codable, Hashable, Equatable {
  var url: URL? { get set }
  var data: Foundation.Data? { get set }
  init(url: URL, data: Data)
}// end public protocol OSCAUrlData

