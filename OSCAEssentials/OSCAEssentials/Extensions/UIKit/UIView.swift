//
//  UIView.swift
//  OSCAEssentials
//
//  Created by MAMMUT Nithammer on 11.12.20.
//  Reviewed by Stephan Breidenbach on 11.02.22
//

import UIKit

public extension UIView {
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }// end func roundCorners
  
  func addGradient(colors: [UIColor] = [.blue, .white], locations: [NSNumber] = [0, 2], startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0), type: CAGradientLayerType = .axial) {
    let gradient = CAGradientLayer()
    
    gradient.frame.size = frame.size
    gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
    
    // Iterates through the colors array and casts the individual elements to cgColor
    // Alternatively, one could use a CGColor Array in the first place or do this cast in a for-loop
    gradient.colors = colors.map { $0.cgColor }
    
    gradient.locations = locations
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    
    // Insert the new layer at the bottom-most position
    // This way we won't cover any other elements
    layer.insertSublayer(gradient, at: 0)
  }// end func addGradient
  
  func asImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    return renderer.image { rendererContext in
      layer.render(in: rendererContext.cgContext)
    }
  }// end func asImage
  
  func addShadow(color: CGColor = UIColor.black.cgColor,
                 opacity: Float,
                 radius: CGFloat,
                 offset: CGSize) {
    layer.shadowColor = color
    layer.shadowOpacity = opacity
    layer.shadowRadius = radius
    layer.shadowOffset = offset
    layer.masksToBounds = false
  }
  
  func addShadow(with shadow: OSCAShadowSettings) {
    layer.shadowColor = shadow.color
    layer.shadowOpacity = shadow.opacity
    layer.shadowRadius = shadow.radius
    layer.shadowOffset = shadow.offset
    layer.masksToBounds = false
  }
  
  enum ViewSide {
    case left, right, top, bottom
  }// end enum ViewSide
  
  func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
    
    let border = CALayer()
    border.backgroundColor = color
    
    switch side {
    case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
    case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
    case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
    case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY-thickness, width: frame.width, height: thickness)
    }// end switch case
    
    layer.addSublayer(border)
  }// end func addBorder to side
  
   /**
    This function will change the corner `radius` of the view, but is limited to a radius half the height of itself.
    
    ```
    let cornerRadius = (Double(self.frame.height) / 2) < radius
      ? Double(self.frame.height) / 2
      : radius
    self.layer.cornerRadius = cornerRadius
    ```
    
    - Parameter radius: The applied corner radius
    */
  func addLimitedCornerRadius(_ radius: Double) -> Void {
    let cornerRadius = (Double(self.frame.height) / 2) < radius
      ? Double(self.frame.height) / 2
      : radius
    self.layer.cornerRadius = cornerRadius
  }
}// end extension UIView
