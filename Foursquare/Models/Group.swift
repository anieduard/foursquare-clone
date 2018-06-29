//
//  Group.swift
//  Foursquare
//
//  Created by Eduard Ani on 15/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import Foundation
import Mapper

struct Group: Mappable {
    let places: [Place]
    
    init(map: Mapper) throws {
        try places = map.from("items")
    }
}
