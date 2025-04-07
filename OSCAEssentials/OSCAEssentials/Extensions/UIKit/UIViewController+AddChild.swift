//
//  UIViewController+AddChild.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.04.21.
//
//  based upon https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3


import UIKit

public extension UIViewController {
    
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }// end func add
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }// end func remove
}// end extension UIViewController
