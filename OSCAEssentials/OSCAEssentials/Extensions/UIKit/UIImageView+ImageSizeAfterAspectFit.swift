//
//  UIImageView+ImageSizeAfterAspectFit.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.04.21.
//
//  based upon https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3

import UIKit


public extension UIImageView {

    var imageSizeAfterAspectFit: CGSize {
        var newWidth: CGFloat
        var newHeight: CGFloat

        guard let image = image else { return frame.size }

        if image.size.height >= image.size.width {
            newHeight = frame.size.height
            newWidth = ((image.size.width / (image.size.height)) * newHeight)

            if CGFloat(newWidth) > (frame.size.width) {
                let diff = (frame.size.width) - newWidth
                newHeight += (CGFloat(diff) / newHeight * newHeight)
                newWidth = frame.size.width
            }// end if
        } else {
            newWidth = frame.size.width
            newHeight = (image.size.height / image.size.width) * newWidth

            if newHeight > frame.size.height {
                let diff = Float((frame.size.height) - newHeight)
                newWidth += (CGFloat(diff) / newWidth * newWidth)
                newHeight = frame.size.height
            }// end if
        }// end if
        return .init(width: newWidth, height: newHeight)
    }// end imageSizeAfterAspectFit
}// end extension UIImageView
