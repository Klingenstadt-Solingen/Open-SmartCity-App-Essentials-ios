//
//  ActivityIndicatorView.swift
//
//
//  Created by Mammut Nithammer on 20.01.22.
//

import UIKit

public final class ActivityIndicatorView: UIActivityIndicatorView {
    override public init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)

        setup(backgroundColor: .darkGray)
    }

    public convenience init(style: UIActivityIndicatorView.Style, backgroundColor: UIColor) {
        self.init(style: style)

        setup(backgroundColor: color)
    }

    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(backgroundColor: UIColor) {
        color = .white
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 5.0
        hidesWhenStopped = true
    }
}
