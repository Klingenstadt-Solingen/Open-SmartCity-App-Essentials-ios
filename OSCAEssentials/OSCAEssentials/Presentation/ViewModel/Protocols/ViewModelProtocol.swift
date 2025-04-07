//
//  ViewModelProtocol.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 11.08.22.
//

import Foundation
import Combine

public protocol ViewModelProtocol {
  var dataModule    : OSCAModule                    { get }
  var uiModuleConfig: OSCAUIModuleConfig            { get }
  var colorConfig   : OSCAColorConfig               { get }
  var fontConfig    : OSCAFontConfig                { get }
  var actions       : ViewModelActionsProtocol?     { get }
  var bindings      : Set<AnyCancellable>           { get set }

  func viewDidLoad() -> Void
  func viewWillLayoutSubviews() -> Void
  func viewWillAppear() -> Void
  func viewDidAppear() -> Void
  func viewWillDisappear() -> Void
  func viewDidDisappear() -> Void
}// end public protocol ViewModelProtocol

// MARK: - default implementation
extension ViewModelProtocol where Self: ViewModel {
  public func viewDidLoad() -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
  }// end func viewDidLoad
  
  public func viewWillLayoutSubviews() -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
  }// end func viewWillLayoutSubviews
  
  public func viewWillAppear() -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
  }// end func viewWillAppear
  
  public func viewDidAppear() -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
  }// end func viewDidAppear
  
  public func viewWillDisappear() -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
  }// end func viewWillDisappear
  
  public func viewDidDisappear() -> Void {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
  }// end func viewDidDisappear
  
  
}// end extension ViewModelProtocol
