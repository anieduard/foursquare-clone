//
//  NearbyPlacesServiceSpec.swift
//  Foursquare
//
//  Created by Eduard Ani on 17/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import XCTest
import Swinject
import RxSwift
import CoreLocation
import Moya

class NearbyPlacesServiceSpec: XCTestCase {
    
    private var container: Container!
    private var placesDataSource: PlacesApiMock!
    private var userLocationDataSource: UserLocationServiceMock!
    private var nearbyPlacesService: NearbyPlacesService!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        container = Container()
        container.register(UserLocationDataSource.self) { _ in UserLocationServiceMock() }
            .inObjectScope(.container)
        container.register(PlacesDataSource.self) { _ in PlacesApiMock()}
            .inObjectScope(.container)
        container.register(NearbyPlacesService.self) { resolver in
            NearbyPlacesService(userLocationDataSource: resolver.resolve(UserLocationDataSource.self)!,
                                     placesDataSource: resolver.resolve(PlacesDataSource.self)!)}
        
        placesDataSource = container.resolve(PlacesDataSource.self)! as? PlacesApiMock
        userLocationDataSource = container.resolve(UserLocationDataSource.self)! as? UserLocationServiceMock
        nearbyPlacesService = container.resolve(NearbyPlacesService.self)
    }
    
    func testShouldResolveDependencies() {
        XCTAssertNotNil(placesDataSource)
        XCTAssertNotNil(userLocationDataSource)
        XCTAssertNotNil(nearbyPlacesService)
    }
    
    func testShouldRequestPlacesNearbyUserLocation() {
        _ = nearbyPlacesService.fetchNearbyPlaces()
            .subscribe(onNext: { (places) in
                XCTAssertNotNil(places)
            }, onError: { (_) in
                XCTFail("Should not return error")
            }).disposed(by: disposeBag)
        
        let mockUserLatitude = userLocationDataSource.location.coordinate.latitude
        let mockUserLongitude = userLocationDataSource.location.coordinate.longitude
        
        XCTAssertEqual(placesDataSource.requestedLatitude, mockUserLatitude)
        XCTAssertEqual(placesDataSource.requestedLongitude, mockUserLongitude)
    }
}
