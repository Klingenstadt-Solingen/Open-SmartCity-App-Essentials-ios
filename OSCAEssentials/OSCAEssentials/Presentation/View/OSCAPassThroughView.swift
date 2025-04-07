//
//  OSCAPassThroughView.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 18.03.22.
//

import UIKit

/// Dispatching the overlay container's Touches
/// [pass through view](https://stackoverflow.com/questions/37967555/how-can-i-mimic-the-bottom-sheet-from-the-maps-app)
public class OSCAPassThroughView: UIView {
    var parentClosure: ((/*_ point: */CGPoint,
                        /*with events: */UIEvent?) -> UIView?)?
    public var isPermeable: Bool = true
    
    /// it removes itself from the responder chain.
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if self.isPermeable {
            if view == self {
                if let parentClosure = parentClosure {
                    return parentClosure(point, event)
                }// end if
                return nil
            }// end if
            return view
        } else {
            return view
        }// end if
    }// end override public func hitTest
    
    public static func inject(parentClosure:@escaping ((/*_ point: */CGPoint,
                                                           /*with events: */UIEvent?) -> UIView?),
                              in view: OSCAPassThroughView
    ) -> OSCAPassThroughView {
        let passThroughView: OSCAPassThroughView = view
        passThroughView.parentClosure = parentClosure
        return passThroughView
    }// end public static func inject

}// end public class OSCAPassThroughView
