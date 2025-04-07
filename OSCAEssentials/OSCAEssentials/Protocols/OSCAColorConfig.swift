//
//  OSCAColorConfig.swift
//  OSCAEssentials
//
//  Created by Mammut Nithammer on 17.01.22.
//  Reviewed by Stephan Breidenbach on 07.03.2022
//

import UIKit

public protocol OSCAColorConfig {
  var primaryDarker   : UIColor { get }
  var primaryDark     : UIColor { get }
  /// primary color
  var primaryColor    : UIColor { get set }
  var primaryLight    : UIColor { get }
  
  var primaryLighter  : UIColor { get }
  var accentDarker    : UIColor { get }
  var accentDark      : UIColor { get }
  /// accent color
  var accentColor     : UIColor { get set }
  var accentLight     : UIColor { get }
  var accentLighter   : UIColor { get }
  
  var successDarker   : UIColor { get }
  var successDark     : UIColor { get }
  /// success color
  var successColor    : UIColor { get set }
  var successLight    : UIColor { get }
  var successLighter  : UIColor { get }
  
  var warningDarker   : UIColor { get }
  var warningDark     : UIColor { get }
  /// warning color
  var warningColor    : UIColor { get set }
  var warningLight    : UIColor { get }
  var warningLighter  : UIColor { get }
  
  var errorDarker     : UIColor { get }
  var errorDark       : UIColor { get }
  /// error color
  var errorColor      : UIColor { get set }
  var errorLight      : UIColor { get }
  var errorLighter    : UIColor { get }
  
  var grayDarker      : UIColor { get }
  var grayDark        : UIColor { get }
  /// gray color
  var grayColor       : UIColor { get set }
  var grayLight       : UIColor { get }
  var grayLighter     : UIColor { get }
  
  var blackDarker     : UIColor { get }
  var blackDark       : UIColor { get }
  /// black color
  var blackColor      : UIColor { get set }
  var blackLight      : UIColor { get }
  var blackLighter    : UIColor { get }
  
  var whiteDarker     : UIColor { get }
  var whiteDark       : UIColor { get }
  /// white
  var whiteColor      : UIColor { get set }
  var whiteLight      : UIColor { get }
  var whiteLighter    : UIColor { get }
  
  /// background
  var backgroundColor          : UIColor { get }
  /// secondary background
  var secondaryBackgroundColor : UIColor { get }
  
  /// text
  var textColor: UIColor { get }
  
  /// navigation tint
  var navigationTintColor: UIColor { get }
  
  /// navigation title text
  var navigationTitleTextColor: UIColor { get }
  
  /// navigation bar
  var navigationBarColor: UIColor? { get }
}// end public protocol OSCAColorConfig


