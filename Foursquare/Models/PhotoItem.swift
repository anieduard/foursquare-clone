//
//  PhotoItem.swift
//  Foursquare
//
//  Created by Eduard Ani on 15/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import Foundation
import Mapper

struct PhotoItem: Mappable {
    let imageUrl: String
    
    init(map: Mapper) throws {
        let prefix: String = try map.from("prefix")
        let suffix: String = try map.from("suffix")
        
        imageUrl = "\(prefix)original\(suffix)"
    }
}
