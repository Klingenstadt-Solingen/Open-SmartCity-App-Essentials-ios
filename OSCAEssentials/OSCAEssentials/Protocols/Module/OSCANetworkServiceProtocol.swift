//
//  OSCANetworkServiceProtocol.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 30.01.23.
//

import Foundation
import Combine

// - MARK: Requests
public protocol OSCAClassSchemaRequestResourceProtocol {
  associatedtype Response: Decodable
  var requestClassSchema: URLRequest? { get }
}// end public protocol OSCAClassSchemaRequestResourceProtocol

public protocol OSCAClassRequestResourceProtocol {
  associatedtype Response: Codable, Equatable, Hashable
  var requestClass: URLRequest? { get }
}// end public protocol OSCAClassRequestResourceProtocol

public protocol OSCANetworkConfigRequestResourceProtocol {
  associatedtype Response: OSCAParseConfig
  var requestConfig: URLRequest? { get }
}// end public protocol OSCANetworkConfigRequestResourceProtocol

public protocol OSCAHttpRequestResourceProtocol {
  var request: URLRequest? { get }
}// end public protocol OSCAHttpRequestResourceProtocol

public protocol OSCABundleRequestResourceProtocol {
  associatedtype Response: Codable, Hashable, Equatable
  var requestJSON: (bundle: Bundle, fileURL: URL)? { get }
}// end public protocol OSCABundleRequestResourceProtocol

public protocol OSCAImageDataRequestResourceProtocol {
  associatedtype Response: OSCAImageData
  var requestImageData: URLRequest? { get }
  var objectId: String? { get }
}// end public protocol OSCAImageFileDataRequestResourceProtocol

public protocol OSCAUrlDataRequestResourceProtocol {
  associatedtype Response: OSCAUrlData
  var requestUrlData: URLRequest? { get }
  var url: URL? { get }
}// end public protocol OSCAUrlDataRequestResourceProtocol

public protocol OSCAFunctionRequestResourceProtocol {
  associatedtype CloudFunctionParameter: Codable, Hashable, Equatable
  var requestFunction: URLRequest? { get }
  var cloudFunctionParameter: CloudFunctionParameter? { get }
}// end public protocol OSCAFunctionRequestResource

public protocol OSCAInstallationRequestResourceProtocol {
  associatedtype Response: Codable, Hashable, Equatable
  var requestInstallation: URLRequest? { get }
  var updateInstallation: URLRequest? { get }
}// end public protocol OSCAInstallationRequestResourceProtocol

public protocol OSCASessionRequestResourceProtocol {
  associatedtype Response: Codable, Hashable, Equatable
  var requestSession: URLRequest? { get }
}// end public protocol OSCASessionRequestResourceProtocol

public protocol OSCAUserRequestResourceProtocol {
  associatedtype Response: Codable, Hashable, Equatable
  var sessionTokenValidation: URLRequest? { get }
}// end public protocol OSCAUserRequestResourceProtocol

public protocol OSCAUploadRequestResourceProtocol {
  associatedtype Response: Codable, Hashable, Equatable
  var requestUploadClass: URLRequest? { get }
}// end public protocol OSCAUploadRequestResourceProtocol

public protocol OSCAUpdateRequestResourceProtocol {
  associatedtype Response: Codable, Hashable, Equatable
  var requestUpdateClass: URLRequest? { get }
}

public protocol OSCADeleteRequestResourceProtocol {
  var requestDeleteClassObject: URLRequest? { get }
}

public protocol OSCAUploadFileRequestResourceProtocol {
  associatedtype Response: Codable, Hashable, Equatable
  var requestUploadFile: URLRequest? { get }
}// end public protocol OSCAUploadFileRequestResourceProtocol

public protocol OSCANetworkServiceProtocol: OSCANetworkServiceDownloadProtocol,
                                            OSCANetworkServiceUploadProtocol,
                                            OSCANetworkServicePutProtocol,
                                            OSCANetworkServiceDeleteProtocol,
                                            OSCANetworkServiceUpdateProtocol,
                                            OSCANetworkServiceFetchProtocol {}

// - MARK: download
public protocol OSCANetworkServiceDownloadProtocol {
  @discardableResult
  func download<Request>(_ resource: Request) -> AnyPublisher<[Request.Response], Error> where Request: OSCAClassRequestResourceProtocol
  
  @discardableResult
  func download<Request>(_ resource: Request) -> AnyPublisher<Request.Response, Error> where Request: OSCANetworkConfigRequestResourceProtocol
  
  @discardableResult
  func download<T>(_ resource: OSCAHttpRequestResourceProtocol) -> AnyPublisher<T, Error> where T: Codable & Hashable & Equatable
}// end public protocol OSCANetworkServiceDownloadProtocol

// - MARK: upload
public protocol OSCANetworkServiceUploadProtocol {
  @discardableResult
  func upload<Request>(_ resource: Request) -> AnyPublisher<Request.Response, Error> where Request: OSCAUploadRequestResourceProtocol
  @discardableResult
  func upload<Request>(_ resource: Request) -> AnyPublisher<Request.Response, Error> where Request: OSCAUploadFileRequestResourceProtocol
}// end public protocol OSCANetworkServiceUploadProtocol

// - MARK: put
public protocol OSCANetworkServicePutProtocol {
  /// put
  @discardableResult
  func put<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request: OSCAUploadRequestResourceProtocol
  
  @discardableResult
  func put<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request: OSCAUpdateRequestResourceProtocol
  
  @discardableResult
  func put<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request:
  OSCAInstallationRequestResourceProtocol
}// end public protocol OSCANetworkServicePutProtocol

// - MARK: delete
public protocol OSCANetworkServiceDeleteProtocol {
  @discardableResult
  func delete<Request>(_ resource: Request) -> AnyPublisher<Data, OSCANetworkError> where Request: OSCADeleteRequestResourceProtocol
}
  
// - MARK: update
public protocol OSCANetworkServiceUpdateProtocol {
  @discardableResult
  func update<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request: OSCAInstallationRequestResourceProtocol
}// end public protocol OSCANetworkServiceUpdateProtocol

// - MARK: fetch
public protocol OSCANetworkServiceFetchProtocol {
  /// fetch class schema
  @discardableResult
  func fetch<Request>(_ resource: Request) -> AnyPublisher<[Request.Response], OSCANetworkError> where Request: OSCAClassSchemaRequestResourceProtocol
  /// fetch class
  @discardableResult
  func fetch<Request>(_ resource: Request) -> AnyPublisher<[Request.Response], OSCANetworkError> where Request: OSCAClassRequestResourceProtocol
  /// fetch class from bundle
  @discardableResult
  func fetch<Request>(_ resource: Request) -> AnyPublisher<[Request.Response], OSCANetworkError> where Request: OSCABundleRequestResourceProtocol
  /// fetch image data
  @discardableResult
  func fetch<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request: OSCAImageDataRequestResourceProtocol
  /// fetch `URLData` objects from url
  @discardableResult
  func fetch<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request: OSCAUrlDataRequestResourceProtocol
  /// fetch data from url
  @discardableResult
  func fetch(_ url: URL) -> AnyPublisher<Foundation.Data, OSCANetworkError>
  /// fetch backend configuration
  @discardableResult
  func fetch<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request: OSCANetworkConfigRequestResourceProtocol
  /// fetch cloud function response
  @discardableResult
  func fetch<Response, Request>(_ resource: Request) -> AnyPublisher<Response, OSCANetworkError> where Response: Decodable, Request: OSCAFunctionRequestResourceProtocol
  /// fetch installation on backend
  @discardableResult
  func fetch<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request: OSCAInstallationRequestResourceProtocol
  /// fetch session on backend
  @discardableResult
  func fetch<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request: OSCASessionRequestResourceProtocol
  /// fetch user on backend
  @discardableResult
  func fetch<Request>(_ resource: Request) -> AnyPublisher<Request.Response, OSCANetworkError> where Request: OSCAUserRequestResourceProtocol
}// end public protocol
