//
//  ParseClassSchema.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 20.01.23.
//

import Foundation

/// ```json
///  {
///     "results": [
///       {
///         "className": "CoronaMenu",
///         "fields": {
///           "objectId": {
///             "type": "String"
///           },
///           "createdAt": {
///             "type": "Date"
///           },
///           "updatedAt": {
///             "type": "Date"
///           },
///           "ACL": {
///             "type": "ACL"
///           },
///           "scrapedContent": {
///             "type": "Relation",
///             "targetClass": "ScrapedContent"
///           },
///           "title": {
///             "type": "String"
///           },
///           "segue": {
///             "type": "String"
///           },
///           "position": {
///             "type": "Number"
///           },
///           "section": {
///             "type": "Number"
///           },
///           "linkApple": {
///             "type": "String"
///           },
///           "linkAndroid": {
///             "type": "String"
///           },
///           "icon": {
///             "type": "String"
///           },
///           "cellType": {
///             "type": "String"
///           },
///           "androidPosition": {
///             "type": "Number"
///           },
///           "scrapedContentApple": {
///             "type": "Pointer",
///             "targetClass": "ScrapedContent"
///           }
///         },
///         "classLevelPermissions": {
///           "find": {
///             "*": true
///           },
///           "count": {
///             "*": true
///           },
///           "get": {
///             "*": true
///           },
///           "create": {
///             "*": true
///           },
///           "update": {
///             "*": true
///           },
///           "delete": {
///             "*": true
///           },
///           "addField": {
///             "*": true
///           },
///           "protectedFields": {
///             "*": []
///           }
///         },
///         "indexes": {
///           "_id_": {
///             "_id": 1
///           }
///         }
///       }
///    ]
///  }
///  ```
public struct ParseClassSchema {
  public var className: String?
  public var fields: ParseClassFields?
  
  public enum CodingKeys: String {
    case className
    case fields
  }// public enum CodingKeys
} // end public struct ParseClassSchema

// MARK: - ParseClassSchema conformances
extension ParseClassSchema: Decodable {}
extension ParseClassSchema: Hashable {}
extension ParseClassSchema: Equatable {}
extension ParseClassSchema.CodingKeys: CodingKey {}

extension ParseClassSchema {
  public struct ParseClassFields {
    public var fieldsArray: [ParseClassField]
    
    public enum CodingKeys: String {
      case fieldsArray
    }// end public enum CodingKeys
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: ParseClassSchema.DynamicCodingKeys.self)
      
      //    fieldsArray = container.allKeys.compactMap {
      //      let decodedObject = try? container.decode(ParseClassField.self, forKey: DynamicCodingKeys(stringValue: $0.stringValue)!)
      //      return decodedObject
      //    }// try init fieldsArray
      var tempArray = [ParseClassSchema.ParseClassField]()
      for key in container.allKeys {
        if let decodedObject = try? container.decode(ParseClassSchema.ParseClassField.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!){
          tempArray.append(decodedObject)
        }// end if
      }// end for key in all keys
      fieldsArray = tempArray
    }// end public init from decoder
  }// end public struct ParseClassFields
}// end extension public class ParseClassSchema

// MARK: - ParseClassFields conformances
extension ParseClassSchema.ParseClassFields: Decodable {}
extension ParseClassSchema.ParseClassFields: Hashable {}
extension ParseClassSchema.ParseClassFields: Equatable {}
extension ParseClassSchema.ParseClassFields.CodingKeys: CodingKey {}


// MARK: - DynamicCodingKeys
extension ParseClassSchema {
  /// [based upon](https://swiftsenpai.com/swift/decode-dynamic-keys-json/)
  public struct DynamicCodingKeys: CodingKey {
    
    // use for string-keyed dictionary
    public var stringValue: String
    public init?(stringValue: String) {
      self.stringValue = stringValue
    }// end init
    
    // Use for integer-keyed dictionary
    public var intValue: Int?
    public init?(intValue: Int) {
      // We are not using this, thus just return nil
      return nil
    }// end init
  }// end private struct DynamicCodingKeys
}// extension public struct ParseClassFields


// MARK: - ParseClassField
extension ParseClassSchema {
  public struct ParseClassField {
    public var propertyName: String?
    public var type: String?
    public var targetClass: String?
    
    private enum CodingKeys: String, CodingKey {
      case type, targetClass
    }// end private enum CodingKeys
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: ParseClassSchema.ParseClassField.CodingKeys.self)
      type = try? container.decode(String.self, forKey: ParseClassSchema.ParseClassField.CodingKeys.type)
      targetClass = try? container.decode(String.self, forKey: ParseClassSchema.ParseClassField.CodingKeys.targetClass)
      if let codingKey = container.codingPath.first(where: { $0 is ParseClassSchema.DynamicCodingKeys }) {
        propertyName = codingKey.stringValue
      }
    }// end public init from decoder
  }// end public struct ParseClassField
  
}// end extension public struct ParseClassSchema

extension ParseClassSchema.ParseClassField: Codable {}
extension ParseClassSchema.ParseClassField: Hashable {}
extension ParseClassSchema.ParseClassField: Equatable {}
