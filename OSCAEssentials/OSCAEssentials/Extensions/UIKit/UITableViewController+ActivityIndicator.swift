//
//  UITableViewController+ActivityIndicator.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.04.21.
//
//  based upon https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3
import UIKit

public extension UITableViewController {

    func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let style: UIActivityIndicatorView.Style
        if #available(iOS 13.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                style = UIActivityIndicatorView.Style.medium
            } else {
                style = UIActivityIndicatorView.Style.large
            }// end if
        } else {
            style = .gray
        }// end if

        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)

        return activityIndicator
    }// end makeActivityIndicator
}// extension UITableViewController
