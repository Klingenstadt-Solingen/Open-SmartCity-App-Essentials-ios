//
//  CGSize+ScaledSize.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.04.21.
//
//  based upon https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3
import UIKit

public extension CGSize {
    var scaledSize: CGSize {
        .init(width: width * UIScreen.main.scale,
              height: height * UIScreen.main.scale)// end init
    }// end scaledSize
}// end extension CGSize
