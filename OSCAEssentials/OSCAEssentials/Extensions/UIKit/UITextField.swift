//
//  UITextField.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 20.01.22.
//


import UIKit
import Combine

public extension UITextField {
  var textPublisher: AnyPublisher<String, Never> {
    NotificationCenter.default
      .publisher(for: UITextField.textDidChangeNotification, object: self)
      .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
      .compactMap(\.text) // extracting text and removing optional values (even though the text cannot be nil)
      .eraseToAnyPublisher()
  }// end var textPublisher
  
  
  enum Direction {
    case left
    case right
  }
  
  // add image to textfield
  func withImage(_ image: UIImage, imagePadding: CGFloat = 0, imageColor: UIColor? = nil, separatorColor: UIColor, direction: Direction, tapGesture: UITapGestureRecognizer? = nil) {
    
    let imageContainer = UIView()
    imageContainer.translatesAutoresizingMaskIntoConstraints = false
    imageContainer.widthAnchor.constraint(equalTo: imageContainer.heightAnchor)
      .isActive = true
    
    let imageView = UIImageView(image: image)
    if let tapGesture = tapGesture {
      imageView.addGestureRecognizer(tapGesture)
      imageView.isUserInteractionEnabled = true
    }
    if let color = imageColor {
      image.withRenderingMode(.alwaysTemplate)
      imageView.tintColor = color
    }
    imageView.contentMode = .scaleAspectFit
    
    imageContainer.addSubview(imageView)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.leadingAnchor
      .constraint(equalTo: imageContainer.leadingAnchor,
                  constant: imagePadding)
      .isActive = true
    imageView.trailingAnchor
      .constraint(equalTo: imageContainer.trailingAnchor,
                  constant: -imagePadding)
      .isActive = true
    imageView.topAnchor
      .constraint(equalTo: imageContainer.topAnchor,
                  constant: imagePadding)
      .isActive = true
    imageView.bottomAnchor
      .constraint(equalTo: imageContainer.bottomAnchor,
                  constant: -imagePadding)
      .isActive = true
    
    let seperatorView = UIView()
    seperatorView.widthAnchor.constraint(equalToConstant: 5)
      .isActive = true
    seperatorView.backgroundColor = separatorColor
    
    if Direction.left == direction { // image left
      let stack = UIStackView(
        arrangedSubviews: [imageContainer, seperatorView])
      stack.axis = .horizontal
      
      self.leftView = stack
      self.leftViewMode = .always
      
    } else { // image right
      let stack = UIStackView(
        arrangedSubviews: [seperatorView, imageContainer])
      stack.axis = .horizontal
      stack.distribution = .fill
      stack.alignment = .fill
      stack.translatesAutoresizingMaskIntoConstraints = false
      stack.heightAnchor.constraint(equalToConstant: self.bounds.height)
        .isActive = true
      
      self.rightView = stack
      self.rightViewMode = .always
    }
  }
}// end public extension UITextField
