//
//  KMLParser.swift
//  Solingen
//
//  Created by MAMMUT Nithammer on 03.11.20.
//  Copyright © 2020 Stadt Solingen. All rights reserved.
//

// Implements a limited KML parser.
//     The following KML types are supported:
//             Style,
//             LineString,
//             Point,
//             Polygon,
//             Placemark.
//          All other types are ignored

import MapKit
import UIKit

// swiftlint:disable force_cast file_length force_unwrapping

public class KMLParser: NSObject, XMLParserDelegate {
  private var _styles: [String: KMLStyle] = [:]
  private var _placemarks: [KMLPlacemark] = []
  
  private var _placemark: KMLPlacemark?
  private var _style: KMLStyle?
  
  private var _xmlParser: XMLParser!
  
  // After parsing has completed, this method loops over all placemarks that have
  // been parsed and looks up their corresponding KMLStyle objects according to
  // the placemark's styleUrl property and the global KMLStyle object's identifier.
  func assignStyles() {
    for placemark in self._placemarks {
      if placemark.style == nil,
         let styleUrl = placemark.styleUrl {
        if styleUrl.hasPrefix("#") {
          let styleID = String(styleUrl.dropFirst(1))
          let style = _styles[styleID]
          placemark.style = style
        }// end if
      }// end if
    }// end for placemark in _placemarks
  }// end func assignStyles
  
  public init(url: URL) {
    self._xmlParser = XMLParser(contentsOf: url)
    super.init()
    
    self._xmlParser.delegate = self
  }// end init
  
  public func parseKML() {
    self._xmlParser.parse()
    assignStyles()
  }// end func parseKML
  
  // Return the list of KMLPlacemarks from the object graph that contain overlays
  // (as opposed to simply point annotations).
  public var overlays: [MKOverlay] {
    self._placemarks.compactMap(\.overlay)
  }// end var overlays
  
  // Return the list of KMLPlacemarks from the object graph that are simply
  // MKPointAnnotations and are not MKOverlays.
  public var points: [MKAnnotation] {
    self._placemarks.compactMap(\.point)
  }// end var points
  
  public func viewForAnnotation(_ point: MKAnnotation) -> MKAnnotationView? {
    // Find the KMLPlacemark object that owns this point and get
    // the view from it.
    for placemark in self._placemarks where placemark.point === point {
      return placemark.annotationView
    }// end for placemark in _placemarks
    return nil
  }// end func viewForAnnotation
  
  public func rendererForOverlay(_ overlay: MKOverlay) -> MKOverlayRenderer? {
    // Find the KMLPlacemark object that owns this overlay and get
    // the view from it.
    for placemark in self._placemarks where placemark.overlay === overlay {
      return placemark.overlayPathRenderer
    }// end for placemark in _placemarks
    return nil
  }// end func rendererForOverlay
  
  // MARK: NSXMLParserDelegate
  // swiftlint: disable cyclomatic_complexity
  public func parser(_: XMLParser,
                     didStartElement elementName: String,
                     namespaceURI _: String?,
                     qualifiedName _: String?,
                     attributes attributeDict: [String: String]) {
    let ident = attributeDict["id"]
    
    let style = _placemark?.style ?? _style
    
    // Style and sub-elements
    switch elementName {
    case ELTYPE("Style"):
      if let placemark = _placemark {
        placemark.beginStyleWithIdentifier(ident)
      } else if let identifier = ident {
        _style = KMLStyle(identifier: identifier)
      }
    case ELTYPE("PolyStyle"):
      style?.beginPolyStyle()
    case ELTYPE("LineStyle"):
      style?.beginLineStyle()
    case ELTYPE("color"):
      style?.beginColor()
    case ELTYPE("width"):
      style?.beginWidth()
    case ELTYPE("fill"):
      style?.beginFill()
    case ELTYPE("outline"):
      style?.beginOutline()
      // Placemark and sub-elements
    case ELTYPE("Placemark"):
      _placemark = KMLPlacemark(identifier: ident)
    case ELTYPE("Name"):
      _placemark?.beginName()
    case ELTYPE("Description"):
      _placemark?.beginDescription()
    case ELTYPE("styleUrl"):
      _placemark?.beginStyleUrl()
    case ELTYPE("Polygon"), ELTYPE("Point"), ELTYPE("LineString"):
      _placemark?.beginGeometryOfType(elementName, withIdentifier: ident)
      // Geometry sub-elements
    case ELTYPE("coordinates"):
      _placemark?.geometry?.beginCoordinates()
      // Polygon sub-elements
    case ELTYPE("outerBoundaryIs"):
      _placemark?.polygon?.beginOuterBoundary()
    case ELTYPE("innerBoundaryIs"):
      _placemark?.polygon?.beginInnerBoundary()
    case ELTYPE("LinearRing"):
      _placemark?.polygon?.beginLinearRing()
    default:
      break
    }// end switch case
  }// end func parser did start element
  // swiftlint: enable cyclomatic_complexity
  
  // swiftlint: disable cyclomatic_complexity
  public func parser(_: XMLParser, didEndElement elementName: String, namespaceURI _: String?, qualifiedName _: String?) {
    let style = self._placemark?.style ?? _style
    
    // Style and sub-elements
    switch elementName {
    case ELTYPE("Style"):
      if let placemark = self._placemark {
        placemark.endStyle()
      } else if _style != nil {
        _styles[_style!.identifier!] = _style
        _style = nil
      }
    case ELTYPE("PolyStyle"):
      style?.endPolyStyle()
    case ELTYPE("LineStyle"):
      style?.endLineStyle()
    case ELTYPE("color"):
      style?.endColor()
    case ELTYPE("width"):
      style?.endWidth()
    case ELTYPE("fill"):
      style?.endFill()
    case ELTYPE("outline"):
      style?.endOutline()
      // Placemark and sub-elements
    case ELTYPE("Placemark"):
      if let placemark = self._placemark {
        self._placemarks.append(placemark)
        self._placemark = nil
      }
    case ELTYPE("Name"):
      self._placemark?.endName()
    case ELTYPE("Description"):
      self._placemark?.endDescription()
    case ELTYPE("styleUrl"):
      self._placemark?.endStyleUrl()
    case ELTYPE("Polygon"), ELTYPE("Point"), ELTYPE("LineString"):
      self._placemark?.endGeometry()
      // Geometry sub-elements
    case ELTYPE("coordinates"):
      self._placemark?.geometry?.endCoordinates()
      // Polygon sub-elements
    case ELTYPE("outerBoundaryIs"):
      self._placemark?.polygon?.endOuterBoundary()
    case ELTYPE("innerBoundaryIs"):
      self._placemark?.polygon?.endInnerBoundary()
    case ELTYPE("LinearRing"):
      self._placemark?.polygon?.endLinearRing()
    default:
      break
    }// end switch case
  }// end func parser did end element
  // swiftlint: enable cyclomatic_complexity
  
  public func parser(_: XMLParser, foundCharacters string: String) {
    let element = self._placemark ?? _style
    element?.addString(string)
  }// end func parser foundCharacters
}// end class KMLParser

public struct ELTYPE {
  var typeName: String
  init(_ typeName: String) { self.typeName = typeName }
}// end struct ELTYPE

/// operator overloading: It is an operator used for pattern matching in a case statement.
/// [look here](https://stackoverflow.com/questions/38371870/operator-in-swift)
/// - Parameters:
///   - lhs: element type struct
///   - rhs: matching string
/// - Returns: true / false
func ~= (lhs: ELTYPE, rhs: String) -> Bool {
  rhs.caseInsensitiveCompare(lhs.typeName) == .orderedSame
}// end func ~=

// Begin the implementations of KMLElement and subclasses.  These objects
// act as state machines during parsing time and then once the document is
// fully parsed they act as an object graph for describing the placemarks and
// styles that have been parsed.
public class KMLElement: NSObject {
  let identifier: String?
  fileprivate var accum: String = ""
  
  init(identifier ident: String?) {
    self.identifier = ident
    super.init()
  }// end init
  
  // Returns YES if we're currently parsing an element that has character
  // data contents that we are interested in saving.
  var canAddString: Bool {
    false
  }// end var canAddString
  
  // Add character data parsed from the xml
  func addString(_ str: String) {
    if self.canAddString {
      self.accum += str
    }// end if
  }// end func addString
  
  // Once the character data for an element has been parsed, use clearString to
  // reset the character buffer to get ready to parse another element.
  func clearString() {
    self.accum = ""
  }// end func clearString
}// end class KMLElement

// Represents a KML <Style> element.  <Style> elements may either be specified
// at the top level of the KML document with identifiers or they may be
// specified anonymously within a Geometry element.
public class KMLStyle: KMLElement {
  private var strokeColor: UIColor?
  private var strokeWidth: CGFloat = 0.0
  private var fillColor: UIColor?
  
  private var fill: Bool = false
  private var stroke: Bool = false
  
  private struct Flags: OptionSet {
    var rawValue: Int32
    init(rawValue: Int32) { self.rawValue = rawValue }
    static let inLineStyle = Flags(rawValue: 1 << 0)
    static let inPolyStyle = Flags(rawValue: 1 << 1)
    
    static let inColor = Flags(rawValue: 1 << 2)
    static let inWidth = Flags(rawValue: 1 << 3)
    static let inFill = Flags(rawValue: 1 << 4)
    static let inOutline = Flags(rawValue: 1 << 5)
  }// end struct Flags
  
  private var flags = Flags(rawValue: 0)
  
  override var canAddString: Bool {
    self.flags.intersection([.inColor, .inWidth, .inFill, .inOutline]) != []
  }// end var canAddString
  
  func beginLineStyle() {
    self.flags.insert(.inLineStyle)
  }// end func beginLineStyle
  
  func endLineStyle() {
    self.flags.remove(.inLineStyle)
  }// end func endLineStyle
  
  func beginPolyStyle() {
    self.flags.insert(.inPolyStyle)
  }// end func beginPolyStyle
  
  func endPolyStyle() {
    self.flags.remove(.inPolyStyle)
  }// end func endPolyStyle
  
  func beginColor() {
    self.flags.insert(.inColor)
  }// end func beginColor
  
  func endColor() {
    self.flags.remove(.inColor)
    
    if self.flags.contains(.inLineStyle) {
      self.strokeColor = UIColor(KMLString: accum)
    } else if flags.contains(.inPolyStyle) {
      self.fillColor = UIColor(KMLString: accum)
    }// end if
    
    clearString()
  }// end func endColor
  
  func beginWidth() {
    self.flags.insert(.inWidth)
  }// end func beginWidth
  
  func endWidth() {
    self.flags.remove(.inWidth)
    self.strokeWidth = CGFloat(Double(accum) ?? 0.0)
    self.clearString()
  }// end func endWidth
  
  func beginFill() {
    self.flags.insert(.inFill)
  }// end func beginFill
  
  func endFill() {
    self.flags.remove(.inFill)
    self.fill = (self.accum as NSString).boolValue
    clearString()
  }// end func endFill
  
  func beginOutline() {
    self.flags.insert(.inOutline)
  }// end func beginOutline
  
  func endOutline() {
    self.stroke = (accum as NSString).boolValue
    clearString()
  }// end func endOutline
  
  func applyToOverlayPathRenderer(_ renderer: MKOverlayPathRenderer) {
    renderer.strokeColor = self.strokeColor
    renderer.fillColor = self.fillColor
    renderer.lineWidth = self.strokeWidth
  }// end func applyToOverlayPathRenderer
}// end class KMLStyle

public class KMLGeometry: KMLElement {
  fileprivate struct Flags: OptionSet {
    var rawValue: Int32
    init(rawValue: Int32) { self.rawValue = rawValue }
    
    static let inCoords = Flags(rawValue: 1 << 0)
  }// end struct Flags
  
  fileprivate var flags = Flags(rawValue: 0)
  
  override var canAddString: Bool {
    self.flags.contains(.inCoords)
  }// end var canAddString
  
  func beginCoordinates() {
    self.flags.insert(.inCoords)
  }// end func beginCoordinates
  
  func endCoordinates() {
    self.flags.remove(.inCoords)
  }// end func endCoordinates
  
  // Create (if necessary) and return the corresponding Map Kit MKShape object
  // corresponding to this KML Geometry node.
  var mapkitShape: MKShape? {
    nil
  }// end mapkitShape
  
  // Create (if necessary) and return the corresponding MKOverlayPathRenderer for
  // the MKShape object.
  func createOverlayPathRenderer(_: MKShape) -> MKOverlayPathRenderer? {
    nil
  }// end func createOverlayPathRenderer
}// end class KMLGeometry

// A KMLPoint element corresponds to an MKAnnotation and MKPinAnnotationView
public class KMLPoint: KMLGeometry {
  var point = CLLocationCoordinate2D()
  
  override func endCoordinates() {
    self.flags.remove(.inCoords)
    
    let points = CLLocationCoordinate2D.strToCoords(accum)
    if points.count == 1 {
      point = points[0]
    }
    
    clearString()
  }// end func endCoordinates
  
  override var mapkitShape: MKShape? {
    // KMLPoint corresponds to MKPointAnnotation
    let annotation = MKPointAnnotation()
    annotation.coordinate = point
    return annotation
  }// end var mapkitShape
  
  // KMLPoint does not override MKOverlayPathRenderer: because there is no such
  // thing as an overlay view for a point.  They use MKAnnotationViews which
  // are vended by the KMLPlacemark class.
}// end class KMLPoint

// A KMLPolygon element corresponds to an MKPolygon and MKPolygonView
public class KMLPolygon: KMLGeometry {
  private var outerRing: String = ""
  private var innerRings: [String] = []
  
  private struct PolyFlags: OptionSet {
    var rawValue: Int32
    init(rawValue: Int32) { self.rawValue = rawValue }
    
    static let inOuterBoundary = PolyFlags(rawValue: 1 << 0)
    static let inInnerBoundary = PolyFlags(rawValue: 1 << 1)
    static let inLinearRing = PolyFlags(rawValue: 1 << 2)
  }// end struct PolyFlags
  
  private var polyFlags = PolyFlags(rawValue: 0)
  
  override var canAddString: Bool {
    self.polyFlags.contains(.inLinearRing) && flags.contains(.inCoords)
  }// end var canAddString
  
  func beginOuterBoundary() {
    self.polyFlags.insert(.inOuterBoundary)
  }// end func beginOuterBoundary
  
  func endOuterBoundary() {
    self.polyFlags.remove(.inOuterBoundary)
    self.outerRing = self.accum
    clearString()
  }// end func endOuterBoundary
  
  func beginInnerBoundary() {
    polyFlags.insert(.inInnerBoundary)
  }// end func beginInnerBoundary
  
  func endInnerBoundary() {
    polyFlags.remove(.inInnerBoundary)
    let ring = accum
    innerRings.append(ring)
    clearString()
  }// end func endInnerBoundary
  
  func beginLinearRing() {
    polyFlags.insert(.inLinearRing)
  }// end func beginLinearRing
  
  func endLinearRing() {
    polyFlags.remove(.inLinearRing)
  }// end func endLinearRing
  
  override var mapkitShape: MKShape? {
    // KMLPolygon corresponds to MKPolygon
    
    // The inner and outer rings of the polygon are stored as kml coordinate
    // list strings until we're asked for mapkitShape.  Only once we're here
    // do we lazily transform them into CLLocationCoordinate2D arrays.
    
    // First build up a list of MKPolygon cutouts for the interior rings.
    let innerPolys: [MKPolygon] = innerRings.map { coordStr in
      var coords = CLLocationCoordinate2D.strToCoords(coordStr)
      return MKPolygon(coordinates: &coords, count: coords.count)
    }
    // Now parse the outer ring.
    
    var coords = CLLocationCoordinate2D.strToCoords(outerRing)
    
    // Build a polygon using both the outer coordinates and the list (if applicable)
    // of interior polygons parsed.
    let poly = MKPolygon(coordinates: &coords, count: coords.count, interiorPolygons: innerPolys)
    return poly
  }// end var mapkitShape
  
  override func createOverlayPathRenderer(_ shape: MKShape) -> MKOverlayPathRenderer? {
    let polyPath = MKPolygonRenderer(polygon: shape as! MKPolygon)
    return polyPath
  }// end func createOverlayPathRenderer
}// end class KMLPolygon

public class KMLLineString: KMLGeometry {
  var points: [CLLocationCoordinate2D] = []
  
  override func endCoordinates() {
    self.flags.remove(.inCoords)
    
    self.points = CLLocationCoordinate2D.strToCoords(accum)
    
    clearString()
  }// end func endCoordinates
  
  override var mapkitShape: MKShape? {
    // KMLLineString corresponds to MKPolyline
    MKPolyline(coordinates: &points, count: points.count)
  }// end var mapkitShape
  
  override func createOverlayPathRenderer(_ shape: MKShape) -> MKOverlayPathRenderer? {
    let polyLine = MKPolylineRenderer(polyline: shape as! MKPolyline)
    return polyLine
  }// end func createOverlayPathRenderer
}// end class KMLLineString

public class KMLPlacemark: KMLElement {
  var style: KMLStyle?
  private(set) var geometry: KMLGeometry?
  
  // Corresponds to the title property on MKAnnotation
  private(set) var name: String?
  // Corresponds to the subtitle property on MKAnnotation
  private(set) var placemarkDescription: String?
  
  var styleUrl: String?
  
  private var mkShape: MKShape?
  
  private var _annotationView: MKAnnotationView?
  private var _overlayPathRenderer: MKOverlayPathRenderer?
  
  struct Flags: OptionSet {
    var rawValue: Int32
    init(rawValue: Int32) { self.rawValue = rawValue }
    
    static let inName = Flags(rawValue: 1 << 0)
    static let inDescription = Flags(rawValue: 1 << 1)
    static let inStyle = Flags(rawValue: 1 << 2)
    static let inGeometry = Flags(rawValue: 1 << 3)
    static let inStyleUrl = Flags(rawValue: 1 << 4)
  }// end struct Flags
  
  var flags = Flags(rawValue: 0)
  
  override var canAddString: Bool {
    self.flags.intersection([.inName, .inStyleUrl, .inDescription]) != []
  }// end var canAddString
  
  override func addString(_ str: String) {
    if self.flags.contains(.inStyle) {
      self.style?.addString(str)
    } else if self.flags.contains(.inGeometry) {
      self.geometry?.addString(str)
    } else {
      super.addString(str)
    }// end if
  }// end func addString
  
  func beginName() {
    self.flags.insert(.inName)
  }// end func beginName
  
  func endName() {
    self.flags.remove(.inName)
    self.name = self.accum
    self.clearString()
  }// end func endName
  
  func beginDescription() {
    self.flags.insert(.inDescription)
  }// end func beginDescription
  
  func endDescription() {
    self.flags.remove(.inDescription)
    self.placemarkDescription = self.accum
    clearString()
  }// end func endDescription
  
  func beginStyleUrl() {
    self.flags.insert(.inStyleUrl)
  }// end func beginStyleUrl
  
  func endStyleUrl() {
    self.flags.remove(.inStyleUrl)
    self.styleUrl = self.accum
    clearString()
  }// end func endStyleUrl
  
  func beginStyleWithIdentifier(_ ident: String?) {
    self.flags.insert(.inStyle)
    self.style = KMLStyle(identifier: ident)
  }// end func beginStyleWithIdentifier
  
  func endStyle() {
    self.flags.remove(.inStyle)
  }// end func endStyle
  
  func beginGeometryOfType(_ elementName: String, withIdentifier ident: String?) {
    self.flags.insert(.inGeometry)
    switch elementName {
    case ELTYPE("Point"):
      self.geometry = KMLPoint(identifier: ident)
    case ELTYPE("Polygon"):
      self.geometry = KMLPolygon(identifier: ident)
    case ELTYPE("LineString"):
      self.geometry = KMLLineString(identifier: ident)
    default:
      break
    }// end switch case
  }// end func beginGeometryOfType
  
  func endGeometry() {
    flags.remove(.inGeometry)
  }// end func endGeometry
  
  var polygon: KMLPolygon? {
    geometry as? KMLPolygon
  }// end var polygon
  
  private func _createShape() {
    if mkShape == nil {
      mkShape = geometry?.mapkitShape
      mkShape?.title = name
      // Skip setting the subtitle for now because they're frequently
      // too verbose for viewing on in a callout in most kml files.
      //        mkShape.subtitle = placemarkDescription;
    }// end if
  }// end func _createShape
  
  var overlay: MKOverlay? {
    _createShape()
    
    return mkShape as? MKOverlay
  }// end var overlay
  
  var point: MKAnnotation? {
    _createShape()
    
    // Make sure to check if this is an MKPointAnnotation.  MKOverlays also
    // conform to MKAnnotation, so it isn't sufficient to just check to
    // conformance to MKAnnotation.
    return mkShape as? MKPointAnnotation
  }// end var point
  
  var overlayPathRenderer: MKOverlayPathRenderer? {
    if _overlayPathRenderer == nil {
      if let overlay = self.overlay {
        _overlayPathRenderer = geometry?.createOverlayPathRenderer(overlay as! MKShape)
        style?.applyToOverlayPathRenderer(_overlayPathRenderer!)
      }// end if
    }// end if
    return _overlayPathRenderer
  }// end var overlayPathRenderer
  
  var annotationView: MKAnnotationView? {
    if _annotationView == nil {
      if let annotation = point {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        pin.animatesDrop = true
        _annotationView = pin
      }// end if
    }// end if
    return _annotationView
  }// end var annotationView
}// end class KMLPlacemark
