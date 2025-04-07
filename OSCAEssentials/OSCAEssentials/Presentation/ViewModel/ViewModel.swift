//
//  ViewModel.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 11.08.22.
//

import Foundation
import Combine

open class ViewModel {
  let dependencies  : ViewModel.Dependencies
  
  open var dataModule    : OSCAModule {
    return self.dependencies.dataModule
  }// end var dataModule
  
  public var uiModuleConfig: OSCAUIModuleConfig {
    return self.dependencies.uiModuleConf
  }// end var uiModuleConfig
  
  public var colorConfig   : OSCAColorConfig {
    return self.dependencies.colorConf
  }// end var colorConfig
  
  public var fontConfig    : OSCAFontConfig {
    return self.dependencies.fontConf
  }// end var fontConf
  
  public var actions       : ViewModelActionsProtocol? {
    return self.dependencies.actions
  }// end var actions
  
  public var bindings      : Set<AnyCancellable> = Set<AnyCancellable>()
  
  @Published
  private(set) var state: ViewModel.States = .loading
  
  /// initialize view model from dependencies
  /// - Parameters dependencies: view model dependencies
  public init(dependencies: ViewModel.Dependencies) {
    self.dependencies = dependencies
  }// end init
}// end open class OSCAViewModelClass

// MARK: - Dependencies
extension ViewModel {
  public struct Dependencies {
    public init(dataModule: OSCAModule,
                actions: ViewModelActionsProtocol? = nil,
                uiModuleConf: OSCAUIModuleConfig,
                colorConf: OSCAColorSettings,
                fontConf: OSCAFontSettings) {
      self.dataModule = dataModule
      self.actions = actions
      self.uiModuleConf = uiModuleConf
      self.colorConf = colorConf
      self.fontConf = fontConf
    }// end public memberwise init
    
    /// data module instance
    public let dataModule     : OSCAModule
    /// view model actions instance
    public let actions        : ViewModelActionsProtocol?
    /// UIModule configuration instance
    public let uiModuleConf   : OSCAUIModuleConfig
    /// color configuration instance
    public let colorConf      : OSCAColorSettings
    /// typeface configuration instance
    public let fontConf       : OSCAFontSettings
  }// end public struct Dependencies
}// end extension open ViewModel

// MARK: - Error
extension ViewModel {
  public enum Error: Swift.Error, CustomStringConvertible {
    case networkInvalidRequest
    case networkInvalidResponse
    case networkDataLoading(statusCode: Int, data: Data)
    case networkJSONDecoding(error: Swift.Error)
    case networkIsInternetConnectionFailure
    case networkError
    
    public var description: String {
      switch self {
      case .networkInvalidRequest:
        return "There is a network Problem: invalid request!"
      case .networkInvalidResponse:
        return "There is a network Problem: invalid response!"
      case let .networkDataLoading(statusCode, data):
        return "There is a network Problem: data loading failed with status code \(statusCode): \(data)"
      case let .networkJSONDecoding(error):
#if DEBUG
        return "There is a network Problem: JSON decoding: \(error.localizedDescription)"
#endif
        return "There is a network Problem with JSON decoding"
      case .networkIsInternetConnectionFailure:
        return "There is a network Problem: Internet connection failure!"
      case .networkError:
        return "There is an unspecified network Problem!"
      }// end switch case
    }// end var description
  }// end public enum Error
  
}// end extension open class ViewModel

// MARK: - States
extension ViewModel {
  public enum States {
    /// data loading
    case loading
    /// finished data loading
    case finishedLoading
    /// error
    case error(Swift.Error)
  }// end public enum States
}// end extension ViewModel

extension ViewModel.States : ViewModelStatesProtocol {}

// MARK: - ViewModelProtocol conformance
extension ViewModel: ViewModelProtocol {}
