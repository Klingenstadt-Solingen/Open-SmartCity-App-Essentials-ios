//
//  OSCACopyableLabel.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.10.22.
//

import UIKit

/// [based upon](https://stephenradford.me/make-uilabel-copyable/)
public final class OSCACopyableLabel: UILabel {
  
  override public var canBecomeFirstResponder: Bool {
    return true
  }// end override public var canBecomeFirstResponder
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }// end override init
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }// end required init coder
  
  func sharedInit() {
    isUserInteractionEnabled = true
    let longPressGesture = UILongPressGestureRecognizer(
      target: self,
      action: #selector(showMenu(sender:))
    )// end let longPressGesture
    addGestureRecognizer(longPressGesture)
  }// end func sharedInit
  
  public override func copy(_ sender: Any?) {
    UIPasteboard.general.string = text
    UIMenuController.shared.showMenu(from: self,
                                     rect: self.frame)
  }// end override func copy
  
  @objc func showMenu(sender: Any?) {
    becomeFirstResponder()
    let menu = UIMenuController.shared
    if !menu.isMenuVisible {
      menu.showMenu(from: self, rect: self.frame)
    }// end if
  }// end func showMenu sender
  
  public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return (action == #selector(copy(_:)))
  }// end override func canPerformAction
}// end public final class OSCACopyableLabel
