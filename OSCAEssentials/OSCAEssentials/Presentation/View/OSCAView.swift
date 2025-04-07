//
//  OSCAView.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 29.03.22.
//

import UIKit

/// a custom view which reacts on showing/hiding keyboard
///
/// [keyboard layout guide](https://www.netguru.com/blog/introduction-to-missing-keyboard-layout-guide)
///
/// [from storyboard / NIB](https://github.com/HamzaGhazouani/Stackoverflow/blob/master/CustomViewsSwift/CustomViewsSwift/CustomViewWithXib.swift)
@IBDesignable
public class OSCAView: UIView {
    // MARK: Poperties
    /// lazy constraint representing the keyboard's height
    ///
    /// Initially the height is 0 but changable by the view controller
    private(set) public lazy var keyboardHeightConstraint = keybLayoutGuide.heightAnchor.constraint(equalToConstant: 0)
    private(set) public lazy var keyboardBottomConstraint = keybLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
    
    /// layout guide representing a keyboard's rectangle.
    ///
    /// the height changes its value with animation on the keyboard transition
    public let keybLayoutGuide = UILayoutGuide()
    
    // MARK: Initializer
    public init(from view:UIView) {
        super.init(frame: view.frame)
        commonSetup()
    }
    
    @available(*, unavailable, message: "Use init() method instead.")
    /// deactivate Storyboard / XIB support
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }// end required init? from coder
    
    /// configure the view for auto layout and set a white background
    /// add a layout guide to the receiver and activate two constraints:
    /// * keyboard's height
    /// * keyboard's bottom anchor*
    private func commonSetup() -> Void {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        addLayoutGuide(self.keybLayoutGuide)
        NSLayoutConstraint.activate([self.keyboardHeightConstraint,
                                     // self.keybLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
                                     self.keyboardBottomConstraint
                                    ])
    }// end pirvate func commonSetup
    
    // MARK: Overrides
    /// tell the Auto Layout engine that the view depends on the constraint-based layout system
    public override static var requiresConstraintBasedLayout: Bool {
        true
    }// end override static var requiresConstraintBasedLayout
}// end class OSCAView: UIView
