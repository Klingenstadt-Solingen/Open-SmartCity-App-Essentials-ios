//
//  Environment.swift
//  OSCAEssentials
//
//  Created by MAMMUT Nithammer on 17.05.20.
//  Reviewed by Stephan Breidenbach on 27.01.22
//  Reviewed by Stephan Breidenbach on 13.06.2022
//  Reviewed by Stephan Breidenbach on 22.06.22
//  Reviewed by Stephan Breidenbach on 05.09.2022
//  Copyright © 2020 Stadt Solingen. All rights reserved.
//

import Foundation

// swiftlint:disable nesting missing_docs
public enum Environment {
  // MARK: - Keys
  public enum Keys {
    // swiftlint: disable empty_commented_line
    public enum Plist {
      public static let defaultGeoPointLatitude  = "DEFAULT_GEO_POINT_LATITUDE"  //
      public static let defaultGeoPointLongitude = "DEFAULT_GEO_POINT_LONGITUDE" //
      public static let appStoreUrl              = "APP_STORE_URL"               //
      public static let parseAPIRootURL          = "PARSE_API_ROOT_URL"          //
      public static let parseAPIKey              = "PARSE_API_KEY"               //
      public static let parseRESTAPIKey          = "PARSE_REST_API_KEY"          //
      public static let parseMasterAPIKey        = "PARSE_MASTER_API_KEY"        //
      public static let parseAPIApplicationID    = "PARSE_API_APPLICATION_ID"    //
      public static let devParseAPIRootURL       = "PARSE_API_ROOT_URL_DEV"      //
      public static let devParseRESTAPIKey       = "PARSE_REST_API_KEY_DEV"      //
      public static let devParseMasterAPIKey     = "PARSE_MASTER_API_KEY_DEV"    //
      public static let devParseAPIApplicationID = "PARSE_API_APPLICATION_ID_DEV"//
      public static let devParseAPIKey           = "PARSE_API_KEY_DEV"           //
      public static let imageAPIRootURL          = "ImageBaseURL"                //
      public static let launchScreenTitle        = "LaunchScreenImageName"       //
      public static let splashAnimationName      = "SplashAnimationName"         //
      public static let launchScreenImageName    = "LaunchScreenImageName"       //
      public static let homeTabItems             = "homeTabItems"                //
      public static let deeplinkScheme           = "DEEPLINK_SCHEME"             //
      public static let environment              = "ENVIRONMENT"                 //
    }// end enum Plist
    // swiftlint: enable empty_commented_line
  }// end enum Keys
  
  // MARK: - Plist
  private static func resolvePath(for resourceName: String) -> String? {
    guard !resourceName.isEmpty
    else { return nil }
    var resolvedFilePath: String?
#if SWIFT_PACKAGE
    let bundle = Bundle.module
    guard let filePath = bundle.path(forResource: resourceName,
                                     ofType: "plist")
    else { return nil }
    resolvedFilePath = filePath
#else
    let bundle = Bundle(for: AppConfiguration.self)
    guard let filePath  = bundle.path(forResource: resourceName,
                                      ofType: "plist")
    else { return nil }
    resolvedFilePath = filePath
#endif
    return resolvedFilePath
  }// end func resolvePath for resourceName
  /**
   [`Data(contentsOf:)`](https://sarunw.com/posts/how-to-read-plist-file/)
   */
  public static let apiData: Data? = {
#if DEBUG
    print("\(String(describing: Self.self)): \(#function)")
#endif
    let resourceName = "API_Release"
    // configure secrets
    var resolvedFilePath = resolvePath(for: resourceName)
    guard let resolvedFilePath = resolvedFilePath
    else { fatalError("\(resourceName).plist not found") }
    let pathURL = URL(fileURLWithPath: resolvedFilePath)
    do {
      let plistData = try Data(contentsOf: pathURL)
      return plistData
    } catch {
#if DEBUG
      print("\(String(describing: Self.self)): \(#function)")
#endif
    }// end do catch
#warning("TODO: fatalError")
    fatalError("No data from \(resourceName).plist")
  }()// end private static let apiData
  
  public static let apiDataDev: Data? = {
#if DEBUG
    print("\(String(describing: Self.self)): \(#function)")
#endif
    let resourceName = "API_Develop"
    // configure secrets
    var resolvedFilePath = resolvePath(for: resourceName)
    guard let resolvedFilePath = resolvedFilePath
    else {
#warning("TODO: fatalError")
      fatalError("\(resourceName).plist not found")
    }
    let pathURL = URL(fileURLWithPath: resolvedFilePath)
    do {
      let plistData = try Data(contentsOf: pathURL)
      return plistData
    } catch {
#if DEBUG
      print("\(String(describing: Self.self)): \(#function)")
#endif
    }// end do catch
#warning("TODO: fatalError")
    fatalError("No data from \(resourceName).plist")
  }()// end private static let apiData
  
  public static let apiDictionary: [String: Any] = {
#if DEBUG
    print("\(String(describing: Self.self)): \(#function)")
#endif
    var dict: [String: Any]?
    guard let apiData = Environment.apiData
    else {
#warning("TODO: fatalError")
      fatalError("No data for serialization!")
    }
    do {
      dict        = try PropertyListSerialization.propertyList(from: apiData,
                                                               options: [],
                                                               format: nil) as? [String: Any]
    } catch {
#if DEBUG
      print("\(String(describing: Self.self)): \(#function)")
#endif
    }// end do catch
    guard let dict = dict
    else { return [:] }// end guard
    return dict
  }()// end private static let apiDictionary
  
  public static let apiDictionaryDev: [String: Any] = {
#if DEBUG
    print("\(String(describing: Self.self)): \(#function)")
#endif
    var dict: [String: Any]?
    guard let apiData = Environment.apiDataDev
    else {
#warning("TODO: fatalError")
      fatalError("No data for serialization!")
    }
    do {
      dict        = try PropertyListSerialization.propertyList(from: apiData,
                                                               options: [],
                                                               format: nil) as? [String: Any]
    } catch {
#if DEBUG
      print("\(String(describing: Self.self)): \(#function)")
#endif
    }// end do catch
    guard let dict = dict
    else { return [:] }// end guard
    return dict
  }() // end private static let apiDictionaryDev

  // MARK: - Plist values
  /**
   Decode default geo location from Plist
   */
  public static let defaultGeoPoint: (latitude: Double, longitude: Double) = {
    let dict: [String: Any]
#if DEBUG
    dict = apiDictionaryDev
#else
    dict = apiDictionary
#endif
    guard let defaultGeoPointLatitudeString: String = dict[Keys.Plist.defaultGeoPointLatitude] as? String,
          let defaultGeoPointLongitudeString: String = dict[Keys.Plist.defaultGeoPointLongitude] as? String else {
#warning("TODO: fatalError")
      fatalError("default geo location not set in plist for this environment")
    }// end guard
    guard let defaultGeoPointLatitude = Double(defaultGeoPointLatitudeString),
          let defaultGeoPointLongitude = Double(defaultGeoPointLongitudeString) else {
#warning("TODO: fatalError")
      fatalError("default geo location couldn't have been unwrapped from plist")
    }// end guard
    return (latitude: defaultGeoPointLatitude, longitude: defaultGeoPointLongitude)
  }()// end static let defaultGeoPoint
  
  public static var defaultGeoPointStruct: OSCAGeoPoint  {
    let defaultGeoPointTupel: (latitude:Double, longitude:Double) = Self.defaultGeoPoint
    let geoPointStruct = OSCAGeoPoint(latitude: defaultGeoPointTupel.latitude, longitude: defaultGeoPoint.longitude)
    return geoPointStruct
  }// end static let defaultGeoPoint
  
  /// Decode AppStore URL as `String`from Plist
  public static let appStoreUrl: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let appStoreUrlString = dict[Keys.Plist.appStoreUrl] as? String else {
#warning("TODO: fatalError")
      fatalError("AppStore URL not set in plist for this environment")
    }
    return appStoreUrlString
  }()
  
  /**
   Decode Parse API root URL `String`from Plist
   */
  public static let parseAPIRootURL: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseAPIRootURLString = dict[Keys.Plist.parseAPIRootURL] as? String else {
#warning("TODO: fatalError")
      fatalError("Parse API Root URL not set in plist for this environment")
    }// end guard
    return parseAPIRootURLString
  }()// end static let parseRootURL
  
  /**
   Decode Parse  API-key `String` from Plist
   */
  public static let parseAPIKey: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseAPIKeyString = dict[Keys.Plist.parseAPIKey] as? String else {
#warning("TODO: fatalError")
      fatalError("Parse API Key not set in plist for this environment")
    }// end guard
    return parseAPIKeyString
  }()// end static let parseAPIKey
  
  /**
   Decode Parse REST- API-key `String` from Plist
   */
  public static let parseRESTAPIKey: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseRESTAPIKeyString = dict[Keys.Plist.parseRESTAPIKey] as? String else {
#warning("TODO: fatalError")
      fatalError("Parse REST API Key not set in plist for this environment")
    }// end guard
    return parseRESTAPIKeyString
  }()// end static let parseRESTAPIKey
  
  /**
   Decode Parse Master- API-key `String` from Plist
   */
  public static let parseMasterAPIKey: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseMasterAPIKeyString = dict[Keys.Plist.parseMasterAPIKey] as? String else {
#warning("TODO: fatalError")
      fatalError("Parse Master API Key not set in plist for this environment")
    }// end guard
    return parseMasterAPIKeyString
  }()// end static let parseMasterAPIKey
  
  /**
   Decode Parse API application ID `String`from Plist
   */
  public static let parseAPIApplicationID: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseAPIApplicationIDString = dict[Keys.Plist.parseAPIApplicationID] as? String else {
#warning("TODO: fatalError")
      fatalError("Parse API Application ID not set in plist for this environment")
    }// end guard
    return parseAPIApplicationIDString
  }()// end static let parseAPIApplicationID
  
  /**
   Decode developer Parse API root URL `String`from Plist
   */
  public static let parseAPIRootURLDev: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseAPIRootURLDevString = dict[Keys.Plist.devParseAPIRootURL] as? String else {
#warning("TODO: fatalError")
      fatalError("developer Parse API Root URL not set in plist for this environment")
    }// end guard
    return parseAPIRootURLDevString
  }()// end static let parseRootURL
  
  /**
   Decode developer Parse REST API Key `String`from Plist
   */
  public static let parseRESTAPIKeyDev: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseRESTAPIKeyDevString = dict[Keys.Plist.devParseRESTAPIKey] as? String else {
#warning("TODO: fatalError")
      fatalError("developer Parse REST API key not set in plist for this environment")
    }// end guard
    return parseRESTAPIKeyDevString
  }()// end static let parseRESTAPIKeyDev
  
  /**
   Decode developer Parse master API Key `String`from Plist
   */
  public static let parseMasterAPIKeyDev: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseMasterAPIKeyDevString = dict[Keys.Plist.devParseMasterAPIKey] as? String else {
#warning("TODO: fatalError")
      fatalError("developer Parse master API key not set in plist for this environment")
    }// end guard
    return parseMasterAPIKeyDevString
  }()// end static let parseMasterAPIKeyDev
  
  /**
   Decode developer Parse API application ID `String`from Plist
   */
  public static let parseAPIApplicationIDDev: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseAPIApplicationIDDevString = dict[Keys.Plist.devParseAPIApplicationID] as? String else {
#warning("TODO: fatalError")
      fatalError("developer Parse API Application ID not set in plist for this environment")
    }// end guard
    return parseAPIApplicationIDDevString
  }()// end static let parseAPIApplicationID
  
  /**
   Decode developer Parse  API-key `String` from Plist
   */
  public static let parseAPIKeyDev: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let parseAPIKeyDevString = dict[Keys.Plist.devParseAPIKey] as? String else {
#warning("TODO: fatalError")
      fatalError("developer Parse API Key not set in plist for this environment")
    }// end guard
    return parseAPIKeyDevString
  }()// end static let parseAPIKey
  
  public static let deeplinkScheme: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let deeplinkSchemaString = dict[Keys.Plist.deeplinkScheme] as? String else {
#warning("TODO: fatalError")
      fatalError("application deeplink scheme Key not set in plist for this environment")
    }
    return deeplinkSchemaString
  }()
  
  /**
   Decode Image API root URL `String`from Plist
   */
  public static let imageAPIRootURL: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let imageAPIRootURLNN = dict[Keys.Plist.imageAPIRootURL] as? String
    else {
#warning("TODO: fatalError")
      fatalError("images ApiBaseURL must not be empty in plist")
    }// end guard
    return imageAPIRootURLNN
  }()// end static let imageAPIRootURL
  
  /**
   Decode launch screen image name `String`from Plist
   */
  public static let launchScreenImageName: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let launchScreenImageNameNN = dict[Keys.Plist.launchScreenImageName] as? String
    else {
#warning("TODO: fatalError")
      fatalError("launch screen image name must not be empty in plist")
    }// end guard
    return launchScreenImageNameNN
  }()// end static let launchScreenImageName
  
  /**
   Decode splash animation name `String`from Plist
   */
  public static let splashAnimationName: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let splashAnimationNameNN = dict[Keys.Plist.splashAnimationName] as? String
    else {
#warning("TODO: fatalError")
      fatalError("Splash animation name must not be empty in plist")
    }// end guard
    return splashAnimationNameNN
  }()// end static let splashAnimationName
  
  /**
   Decode launch screen title `String`from Plist
   */
  public static let launchSreenTitle: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let launchScreenTitleNN = dict[Keys.Plist.launchScreenTitle] as? String
    else {
#warning("TODO: fatalError")
      fatalError("launch screen title must not be empty in plist")
    }// end guard
    return launchScreenTitleNN
  }()// end static let imageAPIRootURL
  /**
   Decode environment `String` from Plist
   */
  public static let environment: String = {
    let dict: [String: Any]
#if DEBUG
    dict = Environment.apiDictionaryDev
#else
    dict = Environment.apiDictionary
#endif
    guard let environmentString = dict[Keys.Plist.environment] as? String else {
#warning("TODO: fatalError")
      fatalError("Environment not set in plist for this environment")
    }// end guard
    return environmentString
  }()// end static let environment
}// end public enum Environment

public struct TabItem {
  
}
