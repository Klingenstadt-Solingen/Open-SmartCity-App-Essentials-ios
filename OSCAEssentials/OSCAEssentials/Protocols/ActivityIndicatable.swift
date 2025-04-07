//
//  ActivityIndicatable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 04.02.22.
//

import UIKit

public protocol ActivityIndicatable {
  /// handle to the activity indicator
  var activityIndicatorView: ActivityIndicatorView  { get set }
}// end protocol ActivityIndicatable

public extension ActivityIndicatable where Self: UIViewController {
  /// configure activity indicator view
  /// * add activity indicator subview
  /// * define layout constraints
  func setupActivityIndicator() {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    view.addSubview(self.activityIndicatorView)
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      self.activityIndicatorView.heightAnchor.constraint(equalToConstant: 100.0),
      self.activityIndicatorView.widthAnchor.constraint(equalToConstant: 100.0),
    ])// end activate constraints
  }// end func setupAcitivityIndicator
  
  /// show activity indicator
  /// * make activity indicator visible
  /// * start activity indicator animation
  func showActivityIndicator() {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    self.activityIndicatorView.isHidden = false
    self.activityIndicatorView.startAnimating()
  }// end func showActivityIndicator
  
  /// hide activity indicator
  /// * stop activity indicator animation
  /// * make activity indicator invisible
  func hideActivityIndicator() {
#if DEBUG
    print("\(String(describing: self)): \(#function)")
#endif
    self.activityIndicatorView.stopAnimating()
    self.activityIndicatorView.isHidden = true
  }// end func hideActivityIndicator
}// end public extension protocol ActivityIndicatable
