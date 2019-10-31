//
//  DirectionViewController.swift
//  MiniFacebook
//
//  Created by Rommel Gallofin on 31/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DirectionViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate{
    var latitude: Double?
    var longitude: Double?
    @IBOutlet weak var directionMapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        directionMapView.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let sourceLocation = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: 10.281923, longitude: 123.881524)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.directionMapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.directionMapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.directionMapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
    }
    

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.lightGray
        renderer.lineWidth = 4.0
        
        return renderer
    }

}
