//
//  OSCAImageData.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 04.04.22.
//

import Foundation

public protocol OSCAImageData: Codable, Hashable, Equatable {
  var objectId: String? { get set }
  var imageData: Data? { get set }
  init(objectId: String, imageData: Foundation.Data)
}// end public protocol OSCAImageData
