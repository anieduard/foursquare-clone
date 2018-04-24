//
//  LocationManagerMock.swift
//  FoursquareTests
//
//  Created by Eduard Ani on 24/04/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import CoreLocation

class LocationManagerMock: LocationManager {
    
    var calledRequestWhenInUseAuthorization = false
    var calledRequestLocation = false
    
    weak var delegate: CLLocationManagerDelegate?
    
    func requestWhenInUseAuthorization() {
        calledRequestWhenInUseAuthorization = true
    }
    
    func requestLocation() {
        calledRequestLocation = true
    }
}
