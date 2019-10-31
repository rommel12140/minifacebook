//
//  ProfileViewController.swift
//  MiniFacebook
//
//  Created by DEVG-ODI-2552 on 28/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit
import MapKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    @IBOutlet weak var profilePhoneLabel: UILabel!
    @IBOutlet weak var profileWebsiteLabel: UILabel!
    @IBOutlet weak var profileMapView: MKMapView!
    
    var data:NSObject?
    var longitude: Double?
    var latitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(data?.value(forKey: "id") != nil){
            if let name: String = data?.value(forKey: "name") as? String {
                profileNameLabel.text = "Name: " + name
            }
            if let username: String = data?.value(forKey: "username") as? String {
                profileUsernameLabel.text = "Username: " + username
            }
            if let email: String = data?.value(forKey: "email") as? String {
                profileEmailLabel.text = "Email: " + email
            }
            if let phone: String = data?.value(forKey: "phone") as? String {
                profilePhoneLabel.text = "Phone: " + phone
            }
            if let website: String = data?.value(forKey: "website") as? String {
                profileWebsiteLabel.text = "Website: " + website
            }
            if let lat = 10.281923 as? Double, let long = 123.881524 as? Double{
                let initialLocation = CLLocation(latitude: lat, longitude: long)
                let regionRadius: CLLocationDistance = 500
                let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                          latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                let annotation = Annotation(
                    coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
                profileMapView.addAnnotation(annotation)
                profileMapView.setRegion(coordinateRegion, animated: true)
                self.longitude = long
                self.latitude = lat
            }
            
            profileImage.layer.cornerRadius = 150;
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let identifier = segue.identifier, identifier == "direction" {
            if let vc = segue.destination as? DirectionViewController{
                if longitude != nil,latitude != nil{
                    vc.latitude = latitude
                    vc.longitude = longitude
                }
            }
        }
    }

}
