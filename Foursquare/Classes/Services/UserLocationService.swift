//
//  UserLocationService.swift
//  Foursquare
//
//  Created by Eduard Ani on 24/04/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import CoreLocation
import RxSwift

protocol LocationManager: class {
    
    var delegate: CLLocationManagerDelegate? { get set }
    
    func requestWhenInUseAuthorization()
    func requestLocation()
}

extension CLLocationManager: LocationManager { }

protocol UserLocationDataSource {
    
    func getUserLocation() -> Observable<CLLocation>
}

/**
 A service that handles the logic for user location.
*/
class UserLocationService: NSObject, UserLocationDataSource {
    
    // MARK: - Private properties
    
    private let locationManager: LocationManager
    private let didChangeLocation = PublishSubject<CLLocation>()
    
    // MARK: - Init
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        
        super.init()
        
        self.locationManager.delegate = self
    }
    
    // MARK: - Logic
    
    func getUserLocation() -> Observable<CLLocation> {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        return didChangeLocation
    }
}

// MARK: - CLLocationManagerDelegate

extension UserLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        didChangeLocation.onNext(locations[0])
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didChangeLocation.onError(error)
    }
}
