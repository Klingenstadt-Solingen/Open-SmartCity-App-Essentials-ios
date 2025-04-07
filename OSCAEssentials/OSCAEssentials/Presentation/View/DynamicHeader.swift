//
//  DynamicHeader.swift
//  OSCAEssentials
//
//  Created by MAMMUT Nithammer on 25.01.21.
//  Reviewed by Stephan Breidenbach on 12.02.22
//

import UIKit

public class DynamicHeader: NSObject {
    public var minHeight: DynamicHeaderHeight = .height(0.0)
    public var maxHeight: CGFloat = 0.0
    public var heightContstraint = NSLayoutConstraint()
    public var height: CGFloat = 0.0
    public var showNavigation = false
    public var alphaViews: [UIView] = []

    private var minHeightValue: CGFloat {
        switch minHeight {
        case let .height(height):
            return height
        case let .heightWithStatusBar(height):
            var result: CGFloat = 0.0
            if #available(iOS 13.0, *) {
                if let statusBarHeight = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.statusBarManager?.statusBarFrame.height {
                    result = height + statusBarHeight
                }
            } else {
                result = height + UIApplication.shared.statusBarFrame.size.height
            }

            return result
        case let .heightWithStatusBarAndNavigation(height, navigationBar):
            var result: CGFloat = 0.0
            if #available(iOS 13.0, *) {
                if let statusBarHeight = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.statusBarManager?.statusBarFrame.height {
                    result = height + statusBarHeight
                }
            } else {
                result = height + UIApplication.shared.statusBarFrame.size.height
            }

            return result + (navigationBar?.frame.size.height ?? 0.0)
        }
    }// end private var minHeightValue

    public override init() {}

    public func didScroll(_ scrollView: UIScrollView, with navigationItem: UINavigationItem? = nil, title: String? = nil) {
        let offset = scrollView.contentOffset.y
        var alpha: CGFloat = 0.0
        let newHeaderViewHeight: CGFloat = heightContstraint.constant - offset

        if newHeaderViewHeight > maxHeight {
            heightContstraint.constant = maxHeight
            alpha = 1
            if showNavigation {
                navigationItem?.title = nil
            }
        } else if newHeaderViewHeight < minHeightValue {
            heightContstraint.constant = minHeightValue
            alpha = 0
            if showNavigation {
                navigationItem?.title = title
            }
        } else {
            heightContstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0 // block scroll view
            alpha = (newHeaderViewHeight - minHeightValue) / (maxHeight - minHeightValue)
            if showNavigation {
                navigationItem?.title = nil
            }
        }

        for view in alphaViews {
            view.alpha = alpha
        }
    }// end func didScroll
}// end class DynamicHeader

public enum DynamicHeaderHeight: Equatable {
    case height(CGFloat)
    case heightWithStatusBar(CGFloat)
    case heightWithStatusBarAndNavigation(CGFloat, UINavigationBar?)
}// end enum DynamicHeaderHeight
