//
//  UINavigationController.swift
//  OSCAEssentials
//
//  Created by Ömer Kurutay on 01.06.22.
//

import UIKit

public extension UINavigationController {
  func setup(largeTitles: Bool = false,
             tintColor: UIColor,
             titleTextColor: UIColor,
             barColor: UIColor? = nil
  ) {
    navigationBar.prefersLargeTitles = largeTitles
    navigationBar.tintColor = tintColor
    
    let barAppearance = UINavigationBarAppearance()
    barAppearance.configureWithDefaultBackground()
    barAppearance.titleTextAttributes = [.foregroundColor: titleTextColor]
    barAppearance.largeTitleTextAttributes = [.foregroundColor: titleTextColor]
    barAppearance.backgroundColor = barColor == nil
      ? .secondarySystemBackground
      : barColor
    
    navigationBar.standardAppearance = barAppearance
    
    barAppearance.backgroundColor = barColor == nil
      ? .systemBackground
      : barColor
    
    barAppearance.shadowColor = .clear
    navigationBar.scrollEdgeAppearance = barAppearance
  }
}
