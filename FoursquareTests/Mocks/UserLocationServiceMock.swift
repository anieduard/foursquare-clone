//
//  UserLocationServiceMock.swift
//  Foursquare
//
//  Created by Eduard Ani on 17/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

struct UserLocationServiceMock: UserLocationDataSource {
    
    let location = CLLocation(latitude: -23.5666151, longitude: -46.6463977)
    
    func getUserLocation() -> Observable<CLLocation> {
        return Observable.from(optional: location)
    }
}
