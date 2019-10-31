//
//  Annotation.swift
//  MiniFacebook
//
//  Created by Rommel Gallofin on 31/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
        super.init()
    }
    
}
