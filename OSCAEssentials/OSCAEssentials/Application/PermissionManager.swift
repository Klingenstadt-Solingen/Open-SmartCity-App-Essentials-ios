//
//  PermissionManager.swift
//  OSCAEssentials
//
//  Created by MAMMUT Nithammer on 09.12.20.
//  Reviewed by Stephan Breidenbach on 12.02.22
//

import AVFoundation
import CoreLocation
import EventKit
import Photos
import UIKit

public enum PermissionType {
    case camera
    case calendar
    case location
    case photoLibrary
}// end enum PermissionType

/// A set of methods for permission handling
public class PermissionManager {
    /// Checks if photo library permissions are granted
    public var hasPhotoLibraryPermission: Bool {
        PHPhotoLibrary.authorizationStatus() == .authorized
    }// end var hasPhotoLibraryPermission

    /// Checks if camera permissions are granted
    public var hasCameraPermission: Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }// end var hasCameraPermission

    public var hasCalendarPermission: Bool {
      let status = EKEventStore.authorizationStatus(for: .event)
      var validStatuses: [EKAuthorizationStatus] = [.authorized]
      
      if #available(iOS 17.0, *) {
        validStatuses.append(.fullAccess)
        validStatuses.append(.writeOnly)
      }
      
      return validStatuses.contains(status)
    }// end var hasCalendarPermission

    /// Initializes the class
    public init() {}// end init

    public func getCalendarPermissions(completion: @escaping (Bool, Error?) -> Void) {
      let eventStore = EKEventStore()
      if #available(iOS 17.0, *) {
        eventStore.requestWriteOnlyAccessToEvents(completion: completion)
      } else {
        eventStore.requestAccess(to: .event, completion: completion)
      }
    }// end func getCalendarPermissions

    /**
     Show an Permission Error Alert
    ** Needs reimplementation: There is now TopView!!!
        - Parameter type: type of permission
     */
    public func showPermissionError(type: PermissionType) {
        // TODO: reimplementation: there is no top view!!!
//        if false {
//            var message = ""
//
//            switch type {
//            case .calendar:
//                message = "Sie haben der Freigabe Ihres Kalenders nicht zugestimmt."
//            case .camera:
//                message = "Sie haben der Freigabe Ihres Kamera nicht zugestimmt."
//            case .photoLibrary:
//                message = "Sie haben der Freigabe Ihres Fotobibliothek nicht zugestimmt."
//            case .location:
//                message = "Sie haben der Freigabe Ihres Standorts nicht zugestimmt."
//            }
//            let alert = UIAlertController(title: "Fehler", message: message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Einstellungen", style: .default, handler: { _ in
//                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                    return
//                }
//
//                if UIApplication.shared.canOpenURL(settingsUrl) {
//                    UIApplication.shared.open(settingsUrl, completionHandler: { success in
//                        print("Settings opened: \(success)") // Prints true
//                    })
//                }
//            }))
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            /*
//            guard let topViewController = Utilities.topViewController else { return }
//             
//            DispatchQueue.main.async {
//                UINotificationFeedbackGenerator().notificationOccurred(.error)
//                topViewController.present(alert, animated: true)
//            }
//             */
//        } else {
//            return
//        }
    }// end func showPermissionError
}// end class PermissionManager
