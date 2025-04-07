//
//  LoadingView.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.04.21.
//
import UIKit

public class LoadingView {

    internal static var spinner: UIActivityIndicatorView?

    public static func show() {
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
            if self.spinner == nil, let window = UIApplication.shared.keyWindow {
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                if #available(iOS 13.0, *) {
                    spinner.style = UIActivityIndicatorView.Style.large
                } else {
                    // Fallback on earlier versions
                    spinner.style = UIActivityIndicatorView.Style.gray
                }
                window.addSubview(spinner)

                spinner.startAnimating()
                self.spinner = spinner
            }// end UIApplication.shared.keyWindow
        }// end DispatchQueue.main.async
    }// end static func show

    public static func hide() {
        DispatchQueue.main.async {
            guard let spinner = spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }// end DispatchQueue.main.async
    }// end static func hide

    @objc public static func update() {
        DispatchQueue.main.async {
            if spinner != nil {
                hide()
                show()
            }// end if
        }// end DispatchQueue.main.async
    }// end static func update
}// end class LoadingView
