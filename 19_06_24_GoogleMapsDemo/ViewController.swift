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
    var infoWindowView : UIView?
    
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
//        marker?.icon = UIImage(named: "city_icon")
        marker?.tracksInfoWindowChanges = true
        marker?.map = mapView
    }
    
    private func initializeMapSettings(){
        mapView.delegate = self
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

extension ViewController : GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let cgRectCoordinatesForInfoWindow = CGRect(x: 0, y: 0, width: 200, height: 160)
        infoWindowView = UIView(frame: cgRectCoordinatesForInfoWindow)
        infoWindowView!.backgroundColor = .lightGray
        infoWindowView!.layer.borderColor = CGColor(red: 100.0, green: 100.0, blue: 0.0, alpha: 4.0)
        infoWindowView!.layer.borderWidth = 6.0
        
        let cgRectForLabelOne = CGRect(x: 20, y: 20, width: 100, height: 50)
        let labelOne = UILabel(frame: cgRectForLabelOne)
        labelOne.layer.borderColor = CGColor(red: 100.0, green: 100.0, blue: 200.0, alpha: 5.0)
        labelOne.layer.borderWidth = 6.0
        labelOne.backgroundColor = .white
        labelOne.textColor = .black
        labelOne.textAlignment = .center
        labelOne.text = "\(marker.title!)"
        
        let cgRectForLabelTwo = CGRect(x: 20, y: 90, width: 100, height: 50)
        let labelTwo = UILabel(frame: cgRectForLabelTwo)
        labelTwo.layer.borderColor = CGColor(red: 100.0, green: 100.0, blue: 200.0, alpha: 5.0)
        labelTwo.layer.borderWidth = 6.0
        labelTwo.backgroundColor = .white
        labelTwo.textAlignment = .center
        labelTwo.textColor = .black
        labelTwo.text = "Enjoy"
        
        infoWindowView!.addSubview(labelOne)
        infoWindowView!.addSubview(labelTwo)
        
        return infoWindowView
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        return infoWindowView
    }

    //important in terms of displaying info Window
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("DidTap --- \(marker.title)")
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("Marker position -- \(marker.title) -- \(marker.position.latitude) -- \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Coordinate position -- -- \(coordinate.latitude) -- \(coordinate.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("Did drag ----- Marker position -- \(marker.title) -- \(marker.position.latitude) -- \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("Did begin dragging  ---- Marker position -- \(marker.title) -- \(marker.position.latitude) -- \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("Did End Dragging ---- Marker position -- \(marker.title) -- \(marker.position.latitude) -- \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("DidlongPressInfoWindowOf ---- Marker position -- \(marker.title) -- \(marker.position.latitude) -- \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        print(marker.title)
    }
}
