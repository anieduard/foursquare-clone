//
//  PlacesApiMock.swift
//  Foursquare
//
//  Created by Eduard Ani on 17/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import Foundation
import RxSwift

class PlacesApiMock: PlacesDataSource {
    
    var requestedLatitude: Double?
    var requestedLongitude: Double?
    
    func placesAround(latitude: Double, longitude: Double) -> Observable<LocationPlaces> {
        requestedLatitude = latitude
        requestedLongitude = longitude
        
        return Observable.of(LocationPlaces())
    }
}
