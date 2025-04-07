import MatomoTracker
import Foundation

open class OSCAMatomoTracker {
    public var matomoLogEnabled = false
    public static var shared: OSCAMatomoTracker =  OSCAMatomoTracker()
    public var tracker: MatomoTracker? = nil
    
    public func trackPath(_ path: [String]) {
        if let tracker = tracker {
            tracker.track(view: path)
            logMatomo("Sending path - \(path)")
        }
    }
    
    public func logMatomo(_ string: String) {
        if (matomoLogEnabled) {
            print("Matomo: \(string)")
        }
    }
}
