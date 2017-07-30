//
//  ViewController.swift
//  MapKitDemo
//
//  Created by Sium on 6/20/17.
//  Copyright © 2017 Sium. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapKitView: MKMapView!
    
    var locationManeger = CLLocationManager() // intialize location maneger
    var latValue = CLLocationDegrees()
    var longValue = CLLocationDegrees()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapKitView.showsUserLocation = true
        mapKitView.mapType = MKMapType.standard
        locationManeger.delegate = self
        locationManeger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManeger.requestAlwaysAuthorization()
        
        mapKitView.delegate = self
        
        let latitude = locationManeger.location?.coordinate.latitude
        let longitude = locationManeger.location?.coordinate.longitude
        
        
        print("latitude is \(latitude!)")
        print("longitude is \(longitude!)")
        
        mapKitView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(13.096079826355, 80.2916030883789), MKCoordinateSpanMake(0.01, 0.01)), animated: true)
        
        
        //to draw a marker on the map 
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(13.096079826355, 80.2916030883789)
        annotation.title = "Chennai beach"
        annotation.subtitle = "this is a fucking awesome place"
        mapKitView.addAnnotation(annotation)
        
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2DMake(13.0834903717041, 80.2829437255859)
        annotation2.title = "chennai fort"
        annotation2.subtitle = "here kings fucked"
        mapKitView.addAnnotation(annotation2)
        
        var pointArray = [CLLocationCoordinate2D]()
        
//        pointArray.append(CLLocationCoordinate2DMake(13.096079826355, 80.2916030883789))
//        pointArray.append(CLLocationCoordinate2DMake(13.0834903717041, 80.2829437255859))
        
        var latLongArray : NSArray?
        if let path = Bundle.main.path(forResource: "Stadtions", ofType: "plist"){
            latLongArray = NSArray(contentsOfFile: path)
        }
        
        if let items = latLongArray {
            for item in items {
                let latitude = (item as AnyObject).value(forKey: "lat")
                let longitude = (item as AnyObject).value(forKey: "long")
                let titleString = (item as AnyObject).value(forKey: "title")
                pointArray.append(CLLocationCoordinate2DMake(latitude as! CLLocationDegrees, longitude as! CLLocationDegrees))
                drawMarker(title: titleString as! String, lat: latitude as! CLLocationDegrees, long: longitude as! CLLocationDegrees)
                
            }
        }
        
        
        let path = MKPolyline(coordinates: pointArray, count: pointArray.count)
        
        mapKitView.add(path)
        
        
        
    }
    
//    //to update Current location implement this delegete Method
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0] as! CLLocation
//        let long = userLocation.coordinate.longitude
//        let lat = userLocation.coordinate.latitude
//    }
//
    
    //delegate method of path drawing
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func drawMarker(title: String, lat: CLLocationDegrees , long: CLLocationDegrees){
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapKitView.addAnnotation(annotation)
    }
    
    

}

