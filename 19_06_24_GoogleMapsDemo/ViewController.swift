//
//  ViewController.swift
//  19_06_24_GoogleMapsDemo
//
//  Created by Vishal Jagtap on 14/08/24.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    //    var delhiMarker : GMSMarker?
    //    var puneMarker : GMSMarker?
    //    var mumbaiMarker : GMSMarker?
    var marker : GMSMarker?
    let puneCoordinate = CLLocationCoordinate2D(
        latitude: 18.5204,
        longitude: 73.8567)
    let delhiCoordinate = CLLocationCoordinate2D(
        latitude: 28.7041,
        longitude: 77.1025)
    let mumbaiCoordinate = CLLocationCoordinate2D(
        latitude: 19.0760,
        longitude: 72.8777)
    var gmsCircle : GMSCircle?
    var gmsPolygon : GMSPolygon?
    var gmsPolyline : GMSPolyline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeMapSettings()
        initializeMarkerSettings(coordinate: mumbaiCoordinate, title: "Mumbai")
        drawCircle(position: mumbaiCoordinate, radius: 500.0)
        initializeMarkerSettings(coordinate: puneCoordinate, title: "Pune")
        initializeMarkerSettings(coordinate: delhiCoordinate, title: "Delhi")
//        drawPolygon()
        drawPolyline()
    }
    
    private func initializeMarkerSettings(coordinate : CLLocationCoordinate2D, title : String){
        let cameraPosition = GMSCameraPosition(target: coordinate, zoom: 5.0)
        mapView.camera = cameraPosition
        marker = GMSMarker(position: coordinate)
        marker?.rotation = 30.0
        marker?.title = title
        marker?.opacity = 1.0
        marker?.snippet = "This is \(title) marker"
        marker?.icon = UIImage(named: "city_icon")
        marker?.map = mapView
    }
    
    private func initializeMapSettings(){
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.settings.rotateGestures = true
        mapView.settings.scrollGestures = true
        mapView.settings.tiltGestures = true
        mapView.settings.zoomGestures = true
        mapView.isBuildingsEnabled = true
        mapView.isIndoorEnabled = true
        mapView.isTrafficEnabled = true
        mapView.isMyLocationEnabled = true
        mapView.mapType = .normal
    }
    
    private func drawCircle(position : CLLocationCoordinate2D, radius : CLLocationDistance){
        gmsCircle = GMSCircle(position: position, radius: radius)
        gmsCircle?.fillColor = .brown
        gmsCircle?.strokeColor = .white
        gmsCircle?.strokeWidth = 5.0
        gmsCircle?.title = "Mumbai"
        gmsCircle?.map = mapView
    }
    
    private func drawPolygon(){
        let gmsPathForPolygon = GMSMutablePath()
        gmsPathForPolygon.add(CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.877))
        gmsPathForPolygon.add(CLLocationCoordinate2D(latitude: 26.9124, longitude: 75.7873))
        gmsPathForPolygon.add(CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025))
        gmsPathForPolygon.add(CLLocationCoordinate2D(latitude: 22.5744, longitude: 88.3629))
        gmsPathForPolygon.add(CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.877))
        
        let gmsPolygon = GMSPolygon(path: gmsPathForPolygon)
        gmsPolygon.fillColor = .lightGray
        gmsPolygon.strokeColor = .brown
        gmsPolygon.strokeWidth = 7.0
        gmsPolygon.map = mapView
    }
    
    private func drawPolyline(){
        let gmsPathForPolyline = GMSMutablePath()
        gmsPathForPolyline.add(CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.877))
        gmsPathForPolyline.add(CLLocationCoordinate2D(latitude: 26.9124, longitude: 75.7873))
        gmsPathForPolyline.add(CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025))
        gmsPathForPolyline.add(CLLocationCoordinate2D(latitude: 22.5744, longitude: 88.3629))
        gmsPathForPolyline.add(CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.877))

        let gmsPolyline = GMSPolyline(path: gmsPathForPolyline)
        gmsPolyline.strokeColor = .blue
        gmsPolyline.strokeWidth = 7.0
        gmsPolyline.map = mapView
    }
}
