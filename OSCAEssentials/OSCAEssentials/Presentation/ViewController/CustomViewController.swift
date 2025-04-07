//
//  ViewController.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 29.03.22.
//

import UIKit

/// `UIViewController` derrived class with CustomView-Type `OSCAView`
open class CustomViewController<CustomView: OSCAView>: UIViewController {
    
    // MARK: Properties
    
    var automaticallyAdjustKeybLayoutGuide: Bool = false {
        willSet {
            newValue ? registerForKeybNotifications() : stopObservingKeybNotifications()
        }// end willSet
    }// end var automaticallyAdjustKeybLayoutGuide
    
    public let customView: CustomView
    
    // MARK: Initializer
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        
//        self.initialize()
//    }
    
    public init(view: CustomView) {
        self.customView = view
        self.customView.translatesAutoresizingMaskIntoConstraints = false
        super.init(nibName: nil, bundle: nil)
    }// end init view
    
//    public required init?(coder aDecoder: NSCoder) {
//        guard let customView = CustomView(coder: aDecoder) else {
//            return nil
//        }
//        self.customView = customView
//        self.customView.translatesAutoresizingMaskIntoConstraints = false
//        super.init(coder: aDecoder)
//    }// end public required init? coder aDecoder
    
    @available(*, unavailable, message: "Use init() method instead.")
    public required init?(coder aDecoder: NSCoder) {
#warning("TODO: fatalError")
        fatalError("init(coder:) has not been implemented")
    }// end required init with coder
    
    func initialize() {
        
    }// end func initialize
    
    override open func loadView() {
        super.loadView()
        
        view.addSubview(customView)
        NSLayoutConstraint.activate([
                    customView.topAnchor.constraint(equalTo: view.topAnchor),
                    customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
    }
    
    deinit {
        stopObservingKeybNotifications()
    }// end deinit
}// end class CustomViewController

private extension CustomViewController {
    /// register observer for keyboard notifications:
    /// * keyboard will show
    /// * keyboard will hide
    /// * keyboard will change frame
    func registerForKeybNotifications() -> Void {
        let center = NotificationCenter.default
        // add observer for keyboard will show notification
        center.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            guard let weakSelf = self else { return }
            
            if weakSelf.automaticallyAdjustKeybLayoutGuide {
                let offset = notification.keyboardRect?.height ?? 0
                let animationDuration = notification.keyboardAnimationDuration ?? 0.25
                weakSelf.adjustKeyboardHeightConstraint(byOffset: offset, animationDuration: animationDuration)
            }// end if
        }// end add observer keyboard will show notification
        // add observer for keyboard will hide notification
        center.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            guard let weakSelf = self else { return }
            if weakSelf.automaticallyAdjustKeybLayoutGuide {
                let animationDuration = notification.keyboardAnimationDuration ?? 0.25
                weakSelf.adjustKeyboardHeightConstraint(byOffset: 0, animationDuration: animationDuration)
            }// end if
         }// end add observer keyboard will hide notification
        // add observer for keyboard will change frame notification
        center.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { [weak self] notification in
            guard let weakSelf = self else { return }
            if weakSelf.automaticallyAdjustKeybLayoutGuide,
               let offset = notification.keyboardRect?.height {
                let animationDuration = notification.keyboardAnimationDuration ?? 0.25
                weakSelf.adjustKeyboardHeightConstraint(byOffset: offset, animationDuration: animationDuration)
            }// end if
        }// end add observer keyboard will change frame notification
    }// end func registerForKEybNotifications
    
    /// remove keyboard notification observers
    func stopObservingKeybNotifications() -> Void {
        [
            UIResponder.keyboardWillHideNotification,
            UIResponder.keyboardWillShowNotification,
            UIResponder.keyboardWillChangeFrameNotification
        ].forEach {
            NotificationCenter.default.removeObserver(self, name: $0, object: nil)
        }// end forEach
    }// end func stopObservingKeybNotifications
    
    /// adjust keyboard height constraint
    /// - Parameter offset: change const. offset
    /// - Parameter animationDuration: animation time intervall in seconds
    func adjustKeyboardHeightConstraint(byOffset offset: CGFloat, animationDuration: TimeInterval) -> Void {
        self.customView.keyboardHeightConstraint.constant = offset
        UIView.animate(withDuration: animationDuration) {
            self.customView.layoutIfNeeded()
        }// end animate
    }// end func
}// end private extension class OSCAViewController

private extension Notification {
    var keyboardAnimationDuration: TimeInterval? {
        (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    }// end var keyboardAnimationDuration
    
    var keyboardRect: CGRect? {
        userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }// end var keyBoardRect
}// end private extension Notificationp
