//
//  UIStackView.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 05.11.21.
//

import UIKit

public extension UIStackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
    }// end func removeAllArrangedSubviews

    func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }// end func removeArrangedSubViewProperly
}// end extension class UIStackView
