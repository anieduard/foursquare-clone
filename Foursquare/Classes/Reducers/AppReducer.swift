//
//  AppReducer.swift
//  Foursquare
//
//  Created by Eduard Ani on 22/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import RxSwift
import ReSwift

struct AppReducer {
    
    private let nearbyPlacesService: NearbyPlacesService
    private let disposeBag = DisposeBag()
    
    init(_ nearbyPlacesService: NearbyPlacesService) {
        self.nearbyPlacesService = nearbyPlacesService
    }
    
    func reduce(action: Action, state: FetchedPlacesState?) -> FetchedPlacesState {
        switch action {
        case _ as FetchPlacesAction:
            _ = nearbyPlacesService.fetchNearbyPlaces()
                .subscribe({ (event) in
                    switch event {
                    case .next(let places):
                        store.dispatch(SetPlacesAction(places: places))
                    case .error(let error):
                        store.dispatch(SetErrorAction(error: error))
                    case .completed:
                        break
                    }
                }).disposed(by: disposeBag)
        case let action as SetPlacesAction:
            return FetchedPlacesState(places: Result.finished(action.places))
        case _ as SetErrorAction:
            return FetchedPlacesState(places: Result.failed)
        default:
            break
        }
        
        return FetchedPlacesState(places: .loading)
    }
}
