//
//  AppState.swift
//  Foursquare
//
//  Created by Eduard Ani on 22/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import ReSwift

enum Result {
    case loading
    case failed
    case finished(LocationPlaces)
}

// swiftlint:disable identifier_name
extension Result: Equatable {
    static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.finished(a), .finished(b)):
            return a == b
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }
}

struct FetchedPlacesState: StateType {
    var places: Result = .loading
}

extension FetchedPlacesState: Equatable {
    static func == (lhs: FetchedPlacesState, rhs: FetchedPlacesState) -> Bool {
        return lhs.places == rhs.places
    }
}
