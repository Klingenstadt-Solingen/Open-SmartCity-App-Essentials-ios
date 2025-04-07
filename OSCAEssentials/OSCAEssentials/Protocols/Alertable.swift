//
//  Alertable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 27.04.21.
//
import UIKit

public protocol Alertable {
}// end protocol Alertable

// MARK: Alertable default implementation
public extension Alertable where Self: UIViewController {
  /// shows an confirmable alert dialog
  /// - Parameters:
  ///   - title: descriptive title of the confirmable alert dialog
  ///   - message: alert message text of the confirmable alert dialog
  ///   - preferredStyle: confirmable dialog style
  ///   - completion: optional `() -> Void` closure
  ///   - actionTitle: confirm button title
  ///   - handler: optional closure, which will be invoked after the action button was tapped
  func showAlert(title: String = "",
                 message: String,
                 preferredStyle: UIAlertController.Style = .alert,
                 completion: (() -> Void)? = nil,
                 actionTitle: String = "OK",
                 handler: ((UIAlertAction) -> Void)? = nil
  ) -> Void {
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)// end alert
    alert.addAction(UIAlertAction(title: actionTitle,
                                  style: UIAlertAction.Style.default,
                                  handler: handler))// end alert.addAction
    self.present(alert,
                 animated: true,
                 completion: completion)// end present
  }
  
  func showAlert(title: String =  NSLocalizedString(
        "show_error_alert_title",
        bundle: OSCAEssentials.bundle,
        comment: "the default alert title"),
                   error: Error,
                   preferredStyle: UIAlertController.Style = .alert,
                   completion: (() -> Void)? = nil,
                   actionTitle: String = "OK",
                   handler: ((UIAlertAction) -> Void)? = nil
  ) -> Void {
      var message = NSLocalizedString(
        "show_error_alert_message",
        bundle: OSCAEssentials.bundle,
        comment: "the default alert message")
        // message += "\n \u{2304} \n"
        
        #if DEBUG
        message += " " + error.localizedDescription
        #endif
        self.showAlert(title: title,
                       message: message,
                       preferredStyle: preferredStyle,
                       completion: completion,
                       actionTitle: actionTitle,
                       handler: handler)
  }
  
  /// Shows an action sheet to choose the routing app (Google Maps / Apple Maps)
  /// - Parameter geoPoint: geo location of type `OSCAGeoPoint` to route to
  func showRouteToAlert(geoPoint: OSCAGeoPoint) -> Void {
    let alertTitle = NSLocalizedString(
      "show_route_alert_title",
      bundle: OSCAEssentials.bundle,
      comment: "the route alert's title")
    let alertMsg = NSLocalizedString(
      "show_route_alert_message",
      bundle: OSCAEssentials.bundle,
      comment: "the route alert's message")
    let alertCancelTitle = NSLocalizedString(
      "show_route_alert_cancel_title",
      bundle: OSCAEssentials.bundle,
      comment: "the route alert's cancel title")
    let alert = UIAlertController(title: alertTitle,
                                  message: alertMsg,
                                  preferredStyle: .actionSheet)
    let apple = UIAlertAction(title: "Apple Maps", style: .default) { _ in
      if let mapURL = URL(string: "http://maps.apple.com/?daddr=\(geoPoint.latitude),\(geoPoint.longitude)&dirflg=w") {
        UIApplication.shared.open(mapURL)
      }
    }// end let apple
    let google = UIAlertAction(title: "Google Maps", style: .default) { _ in
      if let mapURL = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(geoPoint.latitude),\(geoPoint.longitude)&travelmode=walking") {
        UIApplication.shared.open(mapURL)
      }
    }// end let google
    let cancel = UIAlertAction(title: alertCancelTitle,
                               style: .cancel,
                               handler: nil)
    alert.addAction(apple)
    alert.addAction(google)
    alert.addAction(cancel)
    
    alert.popoverPresentationController?.sourceView = self.view
    let rect = CGRect(origin: .zero,
                      size: CGSize(width: self.view.bounds.width / 2,
                                   height: self.view.frame.height / 2))
    alert.popoverPresentationController?.sourceRect = rect
    
    /*
     guard let topViewController = Utilities.topViewController else { return }
     topViewController.present(alert, animated: true, hapticNotification: .warning)
     */
    self.present(alert,
                 animated: true,
                 completion: nil)// end present
  }// end static func showRouteToAlert
  
  func showActivity(activityItems: [Any], applicationActivities: [UIActivity]? = nil, excludedActivityTypes: [UIActivity.ActivityType]? = nil) -> Void {
    let activityController = UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: applicationActivities)
    activityController.popoverPresentationController?.sourceView = self.view
    let rect = CGRect(origin: .zero,
                      size: CGSize(width: self.view.bounds.width / 2,
                                   height: self.view.frame.height / 2))
    activityController.popoverPresentationController?.sourceRect = rect
    activityController.excludedActivityTypes = excludedActivityTypes
    
    present(activityController, animated: true, completion: nil)
  }// end func showActivity
}// end extension protocol Alertable
