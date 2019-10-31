//
//  DirectionViewController.swift
//  MiniFacebook
//
//  Created by Rommel Gallofin on 31/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit
import MapKit

class DirectionViewController: UIViewController {
    var latitude: Double?
    var longitude: Double?
    @IBOutlet weak var directionMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if latitude != nil, longitude != nil{
            let initialLocation = CLLocation(latitude: self.latitude!, longitude: self.longitude!)
            let regionRadius: CLLocationDistance = 1000
            let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            let annotation = Annotation(
                coordinate: CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.latitude!))
            directionMapView.addAnnotation(annotation)
            directionMapView.setRegion(coordinateRegion, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
