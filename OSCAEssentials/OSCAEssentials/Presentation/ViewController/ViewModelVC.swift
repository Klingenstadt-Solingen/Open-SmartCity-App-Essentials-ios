//
//  ViewModelVC.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 11.08.22.
//

import UIKit

public protocol ViewModelViewControllerProtocol: NSObjectProtocol {
  associatedtype ViewModelViewController
  var viewModel: ViewModelProtocol { get set }
}// end public protocol ViewModelViewControllerProtocol

public protocol StoryboardViewControllerProtocol: NSObjectProtocol {
  associatedtype StoryboardViewController
  static var defaultFileName: String { get }
  static func instantiateViewController(_ bundle: Bundle?) -> StoryboardViewController
}// end public protocol StoryboardViewControllerProtocol

// MARK: - default implementation
extension StoryboardViewControllerProtocol where Self: UIViewController {
  public static var defaultFileName: String {
#if DEBUG
    print(NSStringFromClass(Self.self))
#endif
    return NSStringFromClass(Self.self).components(separatedBy: ".").last!
  }// end defaultFileName
  
  public static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
#if DEBUG
    print(NSStringFromClass(Self.self))
#endif
    let fileName = defaultFileName
    let storyboard = UIStoryboard(name: fileName, bundle: bundle ?? nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: defaultFileName) as? Self else {
      
      fatalError("Cannot instantiate view controller \(Self.self) from storyboard with name \(fileName)")
    }
    return viewController
  }// end static func instantiateViewController
}// end extension public protocol StoryboardViewControllerProtocol

open class ViewModelVC<StoryboardVC: StoryboardViewControllerProtocol,
                          ViewModel: ViewModelProtocol>: UIViewController {
  /// view model instance injected via create
  var viewModel: ViewModel
  
  /// handle to the activity indicator
  public lazy var activityIndicatorView = ActivityIndicatorView(style: .large)
  
  class func instantiate(viewModel: ViewModel) -> ViewModelVC<StoryboardVC, ViewModel> {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    var bundle: Bundle
#if SWIFT_PACKAGE
    bundle = OSCAEssentials.bundle
#else
    bundle = Bundle(for: Self.self)
#endif
    let storyBoardName = StoryboardVC.defaultFileName
    let storyboard = UIStoryboard(name: storyBoardName, bundle: bundle)
    return storyboard.instantiateViewController(identifier: Self.className) {
      ViewModelVC.init(coder: $0, viewModel: viewModel)
    }// end return closure
  }// end class func instantiate with viewModel
  
  
  init?(coder: NSCoder, viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(coder: coder)
  }// ende init? with coder, viewModel
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) is not supported")
  }// end required public init
}// end open class ViewModelVC

// MARK: - identifier
extension ViewModelVC {
  static var className: String {
    return NSStringFromClass(Self.self).components(separatedBy: ".").last!
  }// end static var className
}// end extension open class ViewModelVC

// MARK: - view controller Alert
extension ViewModelVC: Alertable {}

// MARK: - view controller activity indicator
extension ViewModelVC: ActivityIndicatable {}
