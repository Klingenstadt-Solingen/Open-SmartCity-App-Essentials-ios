import ParseCore

open class OSCAPointOfInterest: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        return "POI"
    }
    
    @NSManaged public var name: String
    @NSManaged public var geopoint: PFGeoPoint
    @NSManaged public var poiCategory: String
    @NSManaged var details: NSArray
    
    public func getDetails() -> [OSCAPointOfInterestDetail]  {
        guard var list = try? JSONDecoder().decode([OSCAPointOfInterestDetail].self, from: JSONSerialization.data(withJSONObject: details))
            .sorted(by: { poiLt, poiRt in
                poiLt.position < poiRt.position
        }) else {
            return []
        }
        return list
    }
}
