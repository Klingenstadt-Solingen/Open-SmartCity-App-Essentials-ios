//
//  UIImage+Placeholder.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 04.04.22.
//

import UIKit

extension UIImage {
    private class DummyClassForBundle {}// end private DummyClassForBundle
    public static var placeholder: UIImage? {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle(for: UIImage.DummyClassForBundle.self)
        #endif
        let image = UIImage(named: "placeholder-svg", in: bundle, compatibleWith: nil)
        return image
    }// end public static var placeholder
}// end extension UIImage
