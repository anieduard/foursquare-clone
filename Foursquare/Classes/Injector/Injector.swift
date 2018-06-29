//
//  Injector.swift
//  Foursquare
//
//  Created by Eduard Ani on 22/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import CoreLocation
import Moya
import Swinject

struct Injector {
    
    private let container: Container = Container()
    
    init() {
        setup()
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
    
    private func setup() {
        setupControllers()
        setupLocationDependencies()
        setupProvider()
        setupNearbyPlacesService()
        setupReducer()
    }
    
    private func setupControllers() {
        container.register(PlacesViewController.self) { _ in
            return PlacesViewController(nibName: "PlacesViewController", bundle: nil)
        }
    }
    
    private func setupLocationDependencies() {
        container.register(LocationManager.self) { _ in CLLocationManager() }
        container.register(UserLocationDataSource.self) { resolver in
            UserLocationService(locationManager: resolver.resolve(LocationManager.self)!)
        }
    }
    
    private func setupProvider() {
        container.register(MoyaProvider<PlacesApi>.self) { _ in MoyaProvider<PlacesApi>() }
    }
    
    private func setupNearbyPlacesService() {
        container.register(PlacesDataSource.self) { resolver in
            PlacesService(provider: resolver.resolve(MoyaProvider<PlacesApi>.self)!)
        }
        container.register(NearbyPlacesService.self) { resolver in
            NearbyPlacesService(userLocationDataSource: resolver.resolve(UserLocationDataSource.self)!,
                                     placesDataSource: resolver.resolve(PlacesDataSource.self)!)
        }
    }
    
    private func setupReducer() {
        container.register(AppReducer.self) { resolver in
            AppReducer(resolver.resolve(NearbyPlacesService.self)!)
        }
    }
}
