//
//  OSCAColorSettings.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.01.22.
//  Reviewed by Stephan Breidenbach on 07.03.22
//

import UIKit

public struct OSCAColorSettings: OSCAColorConfig, Equatable {
  public enum Keys: String, CaseIterable {
    case primary /*    = "primary" */
    case accent /*     = "accent" */
    case success /*    = "success" */
    case warning /*    = "warning" */
    case error /*     = "error" */
    case gray  /*     = "gray" */
    case black /*      = "black" */
    case white /*     = "white" */
  }// end enum Keys
  
  /// primary color darker
  /// this color should be displayed most frequently and be used for important actions
  public var primaryDarker        : UIColor {
    return self.primaryColor.getColor(.darker)
  }// end public var primaryDarker
  
  /// primary color dark
  /// this color should be displayed most frequently and be used for important actions
  public var primaryDark          : UIColor {
    return self.primaryColor.getColor(.dark)
  }// end public var primaryDark
  
  /// primary color
  /// this color should be displayed most frequently and be used for important actions
  public var primaryColor         : UIColor
  
  /// primary color light
  /// this color should be displayed most frequently and be used for important actions
  public var primaryLight         : UIColor {
    return self.primaryColor.getColor(.light)
  }// end public var primaryLight
  
  /// primary color lighter
  /// this color should be displayed most frequently and be used for important actions
  public var primaryLighter       : UIColor {
    return self.primaryColor.getColor(.lighter)
  }// end public var primaryLighter
  
  /// accent color darker
  /// this color should be applied sparingly to highlight information or add personality
  public var accentDarker         : UIColor {
    return self.accentColor.getColor(.darker)
  }// end public var accentDarker
  
  /// accent color dark
  /// this color should be applied sparingly to highlight information or add personality
  public var accentDark           : UIColor {
    return self.accentColor.getColor(.dark)
  }// end public var accentDark
  
  /// accent color
  /// this color should be applied sparingly to highlight information or add personality
  public var accentColor          : UIColor
  
  /// accent color light
  /// this color should be applied sparingly to highlight information or add personality
  public var accentLight          : UIColor {
    return self.accentColor.getColor(.light)
  }// end public var accentLight
  
  /// accent color lighter
  /// this color should be applied sparingly to highlight information or add personality
  public var accentLighter        : UIColor {
    return self.accentColor.getColor(.lighter)
  }// end public var accentLighter
  
  /// success color darker
  /// this color should be used to show positive feedback or status
  public var successDarker        : UIColor {
    return self.successColor.getColor(.darker)
  }// end public var successDarker
  
  /// success color dark
  /// this color should be used to show positive feedback or status
  public var successDark          : UIColor {
    return self.successColor.getColor(.dark)
  }// end public var successDark
  
  /// success color
  /// this color should be used to show positive feedback or status
  public var successColor         : UIColor
  
  /// success color light
  /// this color should be used to show positive feedback or status
  public var successLight         : UIColor {
    return self.successColor.getColor(.light)
  }// end public var successLight
  
  /// success color lighter
  /// this color should be used to show positive feedback or status
  public var successLighter       : UIColor {
    return self.successColor.getColor(.lighter)
  }// end public var successLighter
  
  /// warning color darker
  /// this color should be used to show warning feedback or status
  public var warningDarker        : UIColor {
    return self.warningColor.getColor(.darker)
  }// end public var warningDarker
  
  /// warning color dark
  /// this color should be used to show warning feedback or status
  public var warningDark          : UIColor {
    return self.warningColor.getColor(.dark)
  }// end public var warningDark
  
  /// warning color
  /// this color should be used to show warning feedback or status
  public var warningColor         : UIColor
  
  /// warning color light
  /// this color should be used to show warning feedback or status
  public var warningLight         : UIColor {
    return self.warningColor.getColor(.light)
  }// end public var warningLight
  
  /// warning color lighter
  /// this color should be used to show warning feedback or status
  public var warningLighter       : UIColor {
    return self.warningColor.getColor(.lighter)
  }// end public var warningLighter
  
  /// error color darker
  /// this color should be used to show negative feedback or status
  public var errorDarker          : UIColor {
    return self.errorColor.getColor(.darker)
  }// end public var errorDarker
  
  /// error color dark
  /// this color should be used to show negative feedback or status
  public var errorDark            : UIColor {
    return self.errorColor.getColor(.dark)
  }// end public var errorDark
  
  /// error color
  /// this color should be used to show negative feedback or status
  public var errorColor           : UIColor
  
  /// error color light
  /// this color should be used to show negative feedback or status
  public var errorLight           : UIColor {
    return self.errorColor.getColor(.light)
  }// end public var errorLight
  
  /// error color lighter
  /// this color should be used to show negative feedback or status
  public var errorLighter         : UIColor {
    return self.errorColor.getColor(.lighter)
  }// end public var errorLighter
  
  /// gray color darker
  /// this color should be used for backgrounds, icons, and division lines
  public var grayDarker           : UIColor {
    return self.grayColor.getColor(.darker)
  }// end public var grayDarker
  
  /// gray color dark
  /// this color should be used for backgrounds, icons, and division lines
  public var grayDark             : UIColor {
    return self.grayColor.getColor(.dark)
  }// end public var grayDark
  
  /// gray color
  /// this color should be used for backgrounds, icons, and division lines
  public var grayColor            : UIColor
  
  /// gray color light
  /// this color should be used for backgrounds, icons, and division lines
  public var grayLight            : UIColor {
    return self.grayColor.getColor(.light)
  }// end public var grayLight
  
  /// gray color lighter
  /// this color should be used for backgrounds, icons, and division lines
  public var grayLighter          : UIColor {
    return self.grayColor.getColor(.lighter)
  }// end public var grayLighter
  
  /// black color darker
  /// this color should be used for text
  public var blackDarker          : UIColor {
    return self.blackColor.getColor(.darker)
  }// end public var blackDarker
  
  /// black color dark
  /// this color should be used for text
  public var blackDark            : UIColor {
    return self.blackColor.getColor(.dark)
  }// end public var blackDark
  
  /// black color
  /// this color should be used for text
  public var blackColor           : UIColor
  
  /// black color light
  /// this color should be used for text
  public var blackLight           : UIColor {
    return self.blackColor.getColor(.light)
  }// end public var blackLight
  
  /// black color lighter
  /// this color should be used for text
  public var blackLighter         : UIColor {
    return self.blackColor.getColor(.lighter)
  }// end public var blackLighter
  
  /// white color darker
  /// this color should be used for text
  public var whiteDarker          : UIColor {
    return self.whiteColor.getColor(.darker)
  }// end public whiteDarker
  
  /// white color dark
  /// this color should be used for text
  public var whiteDark            : UIColor {
    return self.whiteColor.getColor(.dark)
  }// end public var whiteDark
  
  /// white color
  /// this color should be used for text
  public var whiteColor           : UIColor
  
  /// white color light
  /// this color should be used for text
  public var whiteLight           : UIColor {
    return self.whiteColor.getColor(.light)
  }// end public var whiteLight
  
  /// white color lighter
  /// this color should be used for text
  public var whiteLighter         : UIColor {
    return self.whiteColor.getColor(.lighter)
  }// end public var whiteLighter
  
  // MARK: Text
  /// text color
  /// this color should be used for text
  public var textColor               : UIColor
  
  // MARK: Background
  /// background color
  /// this color should be used for background color
  public var backgroundColor         : UIColor
  
  /// secondary background color
  /// this color should be used for inner background
  public var secondaryBackgroundColor: UIColor
  
  // MARK: Navigation Bar
  /// navigation tint color
  /// this color should be used for button of the navigation bar
  public var navigationTintColor     : UIColor
  
  /// navigation title text color
  /// this color should be used for the title text of the navigation bar
  public var navigationTitleTextColor: UIColor
  
  /// navigation bar color
  /// this color should be used for the background of the navigation bar
  public var navigationBarColor      : UIColor?
  
  public init(primaryColor            : UIColor  = UIColor(rgb:0x005AAA),
              accentColor             : UIColor  = UIColor(rgb:0xFFD503),
              successColor            : UIColor  = UIColor(rgb:0x3CC13B),
              warningColor            : UIColor  = UIColor(rgb:0xF3BB1C),
              errorColor              : UIColor  = UIColor(rgb:0xF03738),
              grayColor               : UIColor  = UIColor(rgb:0xC2C9D1),
              blackColor              : UIColor  = UIColor(rgb:0x000000),
              whiteColor              : UIColor  = UIColor(rgb:0xFFFFFF),
              textColor               : UIColor? = nil,
              backgroundColor         : UIColor? = nil,
              secondaryBackgroundColor: UIColor? = nil,
              navigationTintColor     : UIColor  = UIColor.systemBlue,
              navigationTitleTextColor: UIColor  = UIColor.label,
              navigationBarColor      : UIColor? = nil
  ) {
    self.primaryColor             = primaryColor
    self.accentColor              = accentColor
    self.successColor             = successColor
    self.warningColor             = warningColor
    self.errorColor               = errorColor
    self.grayColor                = grayColor
    self.blackColor               = blackColor
    self.whiteColor               = whiteColor
    
    if let color = textColor {
      self.textColor = color
    } else {
      if UITraitCollection.current.userInterfaceStyle == .light {
        self.textColor = blackColor
      } else {
        self.textColor = whiteColor.darker()
      }
    }
    
    if let color = backgroundColor {
      self.backgroundColor = color
    } else {
      if UITraitCollection.current.userInterfaceStyle == .light {
        self.backgroundColor = whiteColor
      } else {
        self.backgroundColor = blackColor
      }
    }
    
    if let color = secondaryBackgroundColor {
      self.secondaryBackgroundColor = color
    } else {
      if UITraitCollection.current.userInterfaceStyle == .light {
        self.secondaryBackgroundColor = whiteColor
      } else {
        self.secondaryBackgroundColor = blackColor.lighter()
      }
    }
    
    self.navigationTintColor      = navigationTintColor
    self.navigationTitleTextColor = navigationTitleTextColor
    self.navigationBarColor       = navigationBarColor ?? .systemBackground
  }// end public convenience initializer
}// end public struct OSCAColorSettings
