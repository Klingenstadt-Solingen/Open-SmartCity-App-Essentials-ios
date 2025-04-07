//
//  LocationManager.swift
//  OSCAEssentials
//
//  Created by MAMMUT Nithammer on 09.12.20.
//  Reviewed by Stephan Breidenbach on 12.02.22
//

import CoreLocation
import Foundation

public enum LocationManagerError: Error, Equatable {
    
}// end public enum LocationManagerError

public extension NSNotification.Name {
    static let userLocationDidChange = Notification.Name(rawValue: "OSCAEssentials_LocationManager_UserLocationDidChange")
    static let userHeadingDidChange = Notification.Name(rawValue: "OSCAEssentials_LocationManager_UserHeadingDidChange")
    static let userLocationPermissionDidChange = Notification.Name(rawValue: "OSCAEssentials_LocationManager_UserLocationPermissionDidChange")
}// end extension NSNotification.Name

/// Singleton containing methods for location management
public class LocationManager: NSObject {
    /// Shared instance of `LocationManager`, used for ad-hoc access to the LocationManager throughout the app.
    public static let shared = LocationManager()

    /// The status of the location authorization
    public var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }// end var authorizationStatus

    /// Returns if location services are globally enabled
    public var isUserLocationAvailable: Bool {
        return CLLocationManager.locationServicesEnabled()
    }// end viar isUserLocationAvailable

    /// The users current location
    public var userLocation: CLLocation? {
        didSet {
            NotificationCenter.default.post(name: .userLocationDidChange, object: nil, userInfo: nil)
        }
    }// end var userLocation
    
    /// The users current location as `OSCAGeoPoint` struct
    public var userLocationStruct: OSCAGeoPoint? {
        guard let userLocation = self.userLocation else { return nil }
        return OSCAGeoPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }// end var userLocationStruct

    /// The users current location
    public var userHeading: CLHeading? {
        didSet {
            NotificationCenter.default.post(name: .userHeadingDidChange, object: nil, userInfo: nil)
        }
    }// end var userHeading

    /// Apples location manager
    private var locationManager: CLLocationManager?

    /// Initializes the singleton
    override fileprivate init() {
        super.init()

        /// Fire location update when the users location changes more than 30 meters
        guard let distanceFilter = CLLocationDistance(exactly: 30) else { return }

        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager?.activityType = .otherNavigation
        self.locationManager?.pausesLocationUpdatesAutomatically = true
        self.locationManager?.distanceFilter = distanceFilter
        self.locationManager?.startUpdatingLocation()
        self.locationManager?.startUpdatingHeading()
    }// end override fileprivate init

    /// Asks the user for location permission if needed
    public func askForPermissionIfNeeded() {
        if self.isUserLocationAvailable {
            if self.authorizationStatus != .authorizedAlways || self.authorizationStatus != .authorizedWhenInUse {
                self.locationManager?.requestWhenInUseAuthorization()
            } else {
                #warning("Alert mit Location nicht freigegeben")
            }
        } else {
            #warning("Alert mit Location ist aus")
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    /// Tells the delegate that new location data is available.
    /// - Parameters:
    ///   - manager: The location manager object that generated the update event.
    ///   - locations: An array of `CLLocation` objects containing the location data. This array always contains at least one object representing the current location. If updates were deferred or if multiple locations arrived before they could be delivered, the array may contain additional entries. The objects in the array are organized in the order in which they occurred. Therefore, the most recent location update is at the end of the array.
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = location
        }
    }

    /// Tells the delegate that the location manager received updated heading information.
    /// - Parameters:
    ///   - manager: The location manager object that generated the update event.
    ///   - newHeading: The new heading data.
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.userHeading = newHeading
    }

    /// Tells the delegate its authorization status when the app creates the location manager and when the authorization status changes.
    /// - Parameters:
    ///   - manager: The location manager object reporting the event.
    ///   - status: The authorization status for the app.
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        NotificationCenter.default.post(name: .userLocationPermissionDidChange, object: nil, userInfo: nil)
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.locationManager?.startUpdatingLocation()
            self.locationManager?.startUpdatingHeading()
        }
    }
}
