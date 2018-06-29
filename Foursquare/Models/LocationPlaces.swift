//
//  LocationPlaces.swift
//  Foursquare
//
//  Created by Eduard Ani on 15/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import Foundation
import Mapper

struct LocationPlaces: Mappable {
    let places: [Place]
    let headerFullLocation: String
    
    init(map: Mapper) throws {
        let groups: [Group] = try map.from("groups")
        places = groups.first?.places ?? []
        
        try headerFullLocation = map.from("headerFullLocation")
    }
    
    init() {
        places = []
        headerFullLocation = ""
    }
}

extension LocationPlaces: Equatable {
    static func == (lhs: LocationPlaces, rhs: LocationPlaces) -> Bool {
        return lhs.places == rhs.places && lhs.headerFullLocation == rhs.headerFullLocation
    }
}
