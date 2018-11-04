//
//  ViewController.swift
//  userLocation
//
//  Created by Anna Chang on 11/3/18.
//  Copyright © 2018 Anna Chang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //Map
    @IBOutlet weak var map: MKMapView!
    
    var myCoordinates: CLLocationCoordinate2D!
    
    let manager = CLLocationManager()
    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
    }
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Directions
        
        map.delegate = self
        map.showsScale = true
        map.showsPointsOfInterest = true
        map.showsUserLocation = true
        
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
        
        let sourceCoordinates = manager.location?.coordinate
        let destinationCoordinates = myCoordinates!
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            guard let response = response else {
                if let error = error {
                    print("Error!")
                }
                return
            }
            let route = response.routes[0]
            self.map.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegion(rect), animated: true)
        })
        
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
}

