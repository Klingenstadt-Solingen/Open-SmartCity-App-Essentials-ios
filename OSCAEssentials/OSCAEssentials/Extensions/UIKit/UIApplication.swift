//
//  UIApplication.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 05.11.21.
//

import UIKit


/// The centralized point of control and coordination for apps running in iOS.
extension UIApplication {
    /// The backdrop for your app’s user interface and the object that dispatches events to your views.
    /// - Warning: Only available at iOS 13 and higher
    @available(iOS 13.0, *)
    var currentWindow: UIWindow? {
        connectedScenes.filter { $0.activationState == .foregroundActive }.map { $0 as? UIWindowScene }.compactMap { $0 }.first?.windows.first(where: { $0.isKeyWindow })
    }// end var currentWindow

    /// The backdrop for your app’s user interface and the object that dispatches events to your views.
    var keyWindow: UIWindow? {
        UIApplication.shared.windows.first { $0.isKeyWindow }
    }// end var keyWindow

    /// Gets the top most viewcontroller
    /// - Parameter base: The current `UIViewController`
    /// - Returns: The top most `UIViewController`. Can be `nil`
    /// - Warning: Only available at iOS 13 and higher
    @available(iOS 13.0, *)
    class func topMostViewController(base: UIViewController? = UIApplication.shared.currentWindow?.rootViewController) -> UIViewController? {
        if let navigation = base as? UINavigationController {
            return topMostViewController(base: navigation.visibleViewController)
        }// end if

        if let tabBar = base as? UITabBarController {
            let moreNavigationController = tabBar.moreNavigationController

            if let topController = moreNavigationController.topViewController, topController.view.window != nil {
                return topMostViewController(base: topController)
            } else if let selected = tabBar.selectedViewController {
                return topMostViewController(base: selected)
            }// end if
        }// end if
        if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }// end if
        return base
    }// end class func topMostViewController

    /// Gets the top most viewcontroller
    /// - Parameter base: The current `UIViewController`
    /// - Returns: The top most `UIViewController`. Can be `nil`
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigation = base as? UINavigationController {
            return topViewController(base: navigation.visibleViewController)
        }// end if
        if let tabBar = base as? UITabBarController {
            if let selected = tabBar.selectedViewController {
                return topViewController(base: selected)
            }// end if
        }// end if
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }// end if
        return base
    }// end class func topViewController
}// end extension class UIApplication
