//
//  Actions.swift
//  Foursquare
//
//  Created by Eduard Ani on 22/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import ReSwift

struct FetchPlacesAction: Action {}

struct SetPlacesAction: Action, Equatable {
    let places: LocationPlaces
    
    static func == (lhs: SetPlacesAction, rhs: SetPlacesAction) -> Bool {
        return lhs.places == rhs.places
    }
}

struct SetErrorAction: Action {
    let error: Error
}
