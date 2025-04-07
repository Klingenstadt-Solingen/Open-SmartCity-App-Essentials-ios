//
//  ParseFile.swift
//  OSCAEssentials
//
//  Created by Ömer Kurutay on 23.03.22.
//

import Foundation

public struct ParseFile {
  public var name  : String?
  public var url   : String?
  public var type: String? = "File"
  
  public init(name: String? = nil,
              url: String? = nil,
              type: String? = "File") {
    self.name = name
    self.url = url
    self.type = type
  }
  
  private enum CodingKeys: String, CodingKey {
    case name
    case url
    case type = "__type"
  }// end private enum CodingKeys
}

extension ParseFile: Codable {}
extension ParseFile: Hashable {}
extension ParseFile: Equatable {}
