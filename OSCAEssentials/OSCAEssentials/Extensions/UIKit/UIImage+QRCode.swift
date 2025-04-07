//
//  UIImage+QRCode.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 30.01.23.
//

import UIKit

extension UIImage {
  /// [based upon](https://medium.com/@dominicfholmes/generating-qr-codes-in-swift-4-b5dacc75727c)
  public convenience init?(from deeplink: URL, with scale: CGFloat = 10) {
    // get string from deeplink
    let deeplinkString = deeplink.absoluteString
    // get data from string
    let data = deeplinkString.data(using: String.Encoding.ascii)
    // get a QR CIFilter
    guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
    // filter input is string data
    qrFilter.setValue(data, forKey: "inputMessage")
    // get the filter output image
    guard let qrImage = qrFilter.outputImage else { return nil }
    // scale image
    let transform = CGAffineTransform(scaleX: scale,
                                      y: scale)
    let scaledQRImage = qrImage.transformed(by: transform)
    // do some processing to geet the UIImage
    let context = CIContext()
    if let cgImage = context.createCGImage(scaledQRImage,
                                           from: scaledQRImage.extent) {
      // scaled qr image
      self.init(cgImage: cgImage)
    } else {
      // qr image
      self.init(ciImage: qrImage)
    }// end if
  }// end public convenience init
}// end extension UIImage
