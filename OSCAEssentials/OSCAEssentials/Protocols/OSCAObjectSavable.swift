//
//  OSCAObjectSavable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 20.06.22.
//

import Foundation
/// [Tutorial](https://medium.com/@ankit.bhana19/save-custom-objects-into-userdefaults-using-codable-in-swift-5-1-protocol-oriented-approach-ae36175180d8)
public protocol OSCAObjectSavable {
  /// accepts an object whose type conforms to `Encodable` protocol and a key that we want to associate with it
  func setObject<Object>(_ object: Object, forKey: String) throws -> Void where Object: Encodable
  
  /// accepts a key by which we will retrieve the associated object from UserDefaults and a type that conforms to the `Decodable` protocol
  func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}// end public protocol OSCAObjectSavable
