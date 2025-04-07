//
//  UIViewController.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 05.11.21.
//
import UIKit

public extension UIViewController {
    /// Presents a view controller modally with haptic feedback.
    /// - Parameters:
    ///   - viewControllerToPresent: The view controller to display over the current view controller’s content.
    ///   - flag: Pass true to animate the presentation; otherwise, pass false.
    ///   - hapticNotification: The haptic feedback type
    ///   - completion: The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, hapticNotification: UINotificationFeedbackGenerator.FeedbackType, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.present(viewControllerToPresent, animated: flag, completion: completion)
            UINotificationFeedbackGenerator().notificationOccurred(hapticNotification)
        }// end DispatchQueue.main.async
    }// end func present
    
    /// `viewController`'s top bar height
    /// [see top bar height](https://stackoverflow.com/questions/46829840/get-safe-area-inset-top-and-bottom-heights)
    var topBarHeight: CGFloat {
        return  safeAreaTopHeight +
                (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }// end var topBarHeight
    
    /// height of the `view`'s to safety area
    /// [see top bar height](https://stackoverflow.com/questions/46829840/get-safe-area-inset-top-and-bottom-heights)
    var safeAreaTopHeight: CGFloat {
        return view.window?.safeAreaInsets.top ?? 0
    }// end var safeAreaInsetsTop
}// end extension class UIViewController

