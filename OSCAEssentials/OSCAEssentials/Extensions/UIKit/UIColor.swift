//
//  UIColor.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 05.11.21.
//
import UIKit

/// An object that stores color data and sometimes opacity.
public extension UIColor {
  static var primary: UIColor {
    UIColor(named: "primaryColor") ?? UIColor(rgb: 0x005AAA)
  }// end static var primary
  
  static var secondary: UIColor {
    UIColor(named: "secondaryColor") ?? UIColor(rgb: 0xFFD503)
  }// end static var secondary
  
  static var uv1Color: UIColor {
    UIColor(named: "uv1Color") ?? UIColor(rgb: 0xC0FFA0)
  }// end static var uv1Color
  
  static var cellBackgroundColor: UIColor {
    UIColor(named: "cellBackgroundColor") ?? UIColor(rgb: 0xFFFFFF)
  }// end static var cellBackgroundColor
  
  // MARK: - Functions
  
  /// Initializes an UIColor object with a hex-code
  /// - Parameters:
  ///   - rgb: String containing a hex-code
  ///   - alpha: Value for transparency. Defaults to 1.0
  convenience init(rgb: UInt32, alpha: CGFloat = 1.0) {
    self.init(
      red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
      green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
      blue: CGFloat(rgb & 0xFF) / 255.0,
      alpha: alpha
    )// end init
  }// end convenience init
  
  // Parse a KML string based color into a UIColor.  KML colors are agbr hex encoded.
  convenience init(KMLString kmlColorString: String) {
      let scanner = Scanner(string: kmlColorString)
      var color64: UInt64 = 0
      scanner.scanHexInt64(&color64)
      let color = UInt32(color64)

      let intA = (color >> 24) & 0x0000_00FF
      let intB = (color >> 16) & 0x0000_00FF
      let intG = (color >> 8) & 0x0000_00FF
      let intR = color & 0x0000_00FF

      let floatR = CGFloat(intR) / 255.0
      let floatG = CGFloat(intG) / 255.0
      let floatB = CGFloat(intB) / 255.0
      let floatA = CGFloat(intA) / 255.0

      self.init(red: floatR, green: floatG, blue: floatB, alpha: floatA)
  }// end convenience init
  
  /**
   [see at](https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor)
   */
  convenience init?(hex: String) {
    let floatR, floatG, floatB, floatA: CGFloat
    
    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])
      
      if hexColor.count == 8 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
          floatR = CGFloat((hexNumber & 0xff000000) >> 24) / 255
          floatG = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
          floatB = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
          floatA = CGFloat(hexNumber & 0x000000ff) / 255
          
          self.init(red: floatR, green: floatG, blue: floatB, alpha: floatA)
          return
        }
      } else if hexColor.count == 6 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
          floatR = CGFloat((hexNumber & 0xff0000) >> 16) / 255
          floatG = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
          floatB = CGFloat(hexNumber & 0x0000ff) / 255
          
          self.init(red: floatR, green: floatG, blue: floatB, alpha: CGFloat(1.0))
          return
        }
      }
    }
    
    return nil
  }
  
  static func getColor(from value: Double, colors: [String], limits: [NSNumber]) -> UIColor {
    var uiColors: [UIColor] = []
    var doubleLimits: [Double] = []
    for color in colors {
      switch color {
      case "red":
        uiColors.append(.systemRed)
      case "orange":
        uiColors.append(.systemOrange)
      case "green":
        uiColors.append(.systemGreen)
      default:
        break
      }
    }
    
    for limit in limits {
      doubleLimits.append(limit.doubleValue)
    }
    
    for (index, doubleLimit) in doubleLimits.enumerated().reversed() where value >= doubleLimit {
      return uiColors[index]
    }
    
    return .black
  }
  
  func toRGB() -> UInt32 {
    var floatR: CGFloat = 0
    var floatG: CGFloat = 0
    var floatB: CGFloat = 0
    var floatA: CGFloat = 0
    getRed(&floatR, green: &floatG, blue: &floatB, alpha: &floatA)
    let rgb: UInt32 = (UInt32)(floatR * 255) << 16 | (UInt32)(floatG * 255) << 8 | (UInt32)(floatB * 255) << 0
    return rgb
  }// end toRGB
  
  /// Converts an UIColor object to a hex-code
  /// - Returns: String containing hex-code */
  func toHexString() -> String {
    let rgb = self.toRGB()
    return String(format: "#%06X", rgb)
  }// end func toHexString
  
  /// https://www.advancedswift.com/lighter-and-darker-uicolor-swift/
  func lighter(componentDelta: CGFloat = 0.1) -> UIColor {
    return makeColor(componentDelta: componentDelta)
  }
  
  func darker(componentDelta: CGFloat = 0.1) -> UIColor {
    return makeColor(componentDelta: -1 * componentDelta)
  }
  
  /// variates the color by `variant`
  /// - Parameters variant: variation
  /// - Returns: color variant
  func getColor(_ variant: OSCAColorVariants) -> UIColor {
    switch variant {
    case .darker:
      return (self.darker()).darker()
    case .dark:
      return self.darker()
    case .baseColor:
      return self
    case .light:
      return self.lighter()
    case .lighter:
      return (self.lighter()).lighter()
    }// end switch case
  }// end public func getColor variant
  
  private func makeColor(componentDelta: CGFloat) -> UIColor {
    var red: CGFloat = 0
    var blue: CGFloat = 0
    var green: CGFloat = 0
    var alpha: CGFloat = 0
    
    // Extract r,g,b,a components from the
    // current UIColor
    getRed(
      &red,
      green: &green,
      blue: &blue,
      alpha: &alpha
    )
    
    // Create a new UIColor modifying each component
    // by componentDelta, making the new UIColor either
    // lighter or darker.
    return UIColor(
      red: add(componentDelta, toComponent: red),
      green: add(componentDelta, toComponent: green),
      blue: add(componentDelta, toComponent: blue),
      alpha: alpha
    )
  }
  
  private func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
    return max(0, min(1, toComponent + value))
  }
  /// get the color's luminance
  var luminance: CGFloat {
    var floatR, floatG, floatB, floatA: CGFloat
    (floatR, floatG, floatB, floatA) = (0, 0, 0, 0)
    self.getRed(&floatR, green: &floatG, blue: &floatB, alpha: &floatA)
    return 0.2126 * floatR + 0.7152 * floatG + 0.0722 * floatB
  }// end var luminance
  
  /// is the color dark?
  /// [see](https://stackoverflow.com/questions/47365583/determining-text-color-from-the-background-color-in-swift)
  var isDarkColor: Bool {
    return self.luminance < 0.50
  }// end var isDarkColor
}// end extension class UIColor

