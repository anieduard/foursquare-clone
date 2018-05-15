//
//  PhotoGroup.swift
//  Foursquare
//
//  Created by Eduard Ani on 15/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import Foundation
import Mapper

struct PhotoGroup: Mappable {
    let items: [PhotoItem]
    
    init(map: Mapper) throws {
        items = try map.from("items")
    }
}
