//
//  UserDefaults+OSCAObjectSavable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 20.06.22.
//  Reviewed by Stephan Breidenbah on 04.07.2022
//

import Foundation
extension UserDefaults: OSCAObjectSavable {
  
  /// save an object in `UserDefaults`with the given key
  /// - Parameter object: object to be saved in `UserDefaults`
  /// - Parameter forKey: given key for `UserDefaults`
  public func setObject<Object>(_ object: Object, forKey: String) throws -> Void where Object: Encodable {
    let encoder = JSONEncoder()
    do {
      let data = try encoder.encode(object)
      set(data, forKey: forKey)
    } catch {
      throw OSCAObjectSavableError.unableToEncode
    }// end do catch
  }// end func setObject
  
  /// retrieve an object from `UserDefaults`for the given key
  /// - Parameter forKey: given key for `UserDefaults`
  /// - Parameter castTo type: given type the from `UserDefaults`retrieved object should be casted to
  /// - Returns object retreived from `UserDefaults`
  public func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
    guard let data = data(forKey: forKey) else { throw OSCAObjectSavableError.noValue }
    let decoder = JSONDecoder()
    do {
      let object = try decoder.decode(type, from: data)
      return object
    } catch {
      throw OSCAObjectSavableError.unableToDecode
    }// end do catch
  }// end func getObject
}// end extension class UserDefaults
