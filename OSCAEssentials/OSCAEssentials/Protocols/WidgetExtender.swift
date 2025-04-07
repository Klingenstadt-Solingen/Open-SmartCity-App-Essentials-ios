//
//  WidgetExtender.swift
//  OSCAEssentials
//
//  Created by Ömer Kurutay on 04.05.23.
//

import UIKit

public protocol WidgetExtender where Self: UIViewController {
  var didLoadContent   : ((Int) -> Void)? { get set }
  var performNavigation: ((Any) -> Void)? { get set }
  
  func refreshContent() -> Void
}
