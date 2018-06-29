//
//  Category.swift
//  Foursquare
//
//  Created by Eduard Ani on 15/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import Foundation
import Mapper

struct Category: Mappable {
    let name: String
    
    init(map: Mapper) throws {
        try name = map.from("name")
    }
}
