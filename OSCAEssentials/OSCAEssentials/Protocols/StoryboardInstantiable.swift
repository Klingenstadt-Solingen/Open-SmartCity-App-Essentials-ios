//
//  StoryboardInstantiable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.04.21.
//
import UIKit

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype ViewController
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> ViewController
}// end protocol StoryboardInstantiable

public extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        #if DEBUG
        print(NSStringFromClass(Self.self))
        #endif
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }// end defaultFileName
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
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
}// end extension protocol StoryboardInstantiable

