//
//  NearbyPlacesService.swift
//  Foursquare
//
//  Created by Eduard Ani on 17/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Moya_ModelMapper
import CoreLocation

struct NearbyPlacesService {
    
    private let placesDataSource: PlacesDataSource
    private let userLocationDataSource: UserLocationDataSource
    
    init(userLocationDataSource: UserLocationDataSource, placesDataSource: PlacesDataSource) {
        self.userLocationDataSource = userLocationDataSource
        self.placesDataSource = placesDataSource
    }
    
    func fetchNearbyPlaces() -> Observable<LocationPlaces> {
        return userLocationDataSource.getUserLocation()
            .flatMap({ (userLocation: CLLocation) -> Observable<LocationPlaces> in
                return self.placesDataSource.placesAround(latitude: userLocation.coordinate.latitude,
                                                          longitude: userLocation.coordinate.longitude)
            })
    }
}
