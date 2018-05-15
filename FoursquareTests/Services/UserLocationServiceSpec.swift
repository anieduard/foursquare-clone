//
//  UserLocationServiceSpec.swift
//  FoursquareTests
//
//  Created by Eduard Ani on 24/04/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import XCTest
import Swinject
import RxSwift
import CoreLocation

class UserLocationServiceSpec: XCTestCase {
    
    private var container: Container!
    private var locationManager: LocationManagerMock!
    private var userLocationService: UserLocationService!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        container = Container()
        container.register(LocationManager.self) { _ in LocationManagerMock() }
            .inObjectScope(.container) // One instance per container
        container.register(UserLocationService.self) { resolver in
            UserLocationService(locationManager: resolver.resolve(LocationManager.self)!)
        }
        
        locationManager = container.resolve(LocationManager.self)! as? LocationManagerMock
        userLocationService = container.resolve(UserLocationService.self)!
    }
    
    func testDependencyDelegateShouldBeWrapperClass() {
        XCTAssertTrue(locationManager.delegate === userLocationService)
    }
    
    func testShouldRequestUserPermission() {
        XCTAssertFalse(locationManager.calledRequestWhenInUseAuthorization)
        _ = userLocationService.getUserLocation()
        XCTAssertTrue(locationManager.calledRequestWhenInUseAuthorization)
    }
    
    func testShouldRequestLocation() {
        XCTAssertFalse(locationManager.calledRequestLocation)
        _ = userLocationService.getUserLocation()
        XCTAssertTrue(locationManager.calledRequestLocation)
    }
    
    func testShouldProvideLocation() {
        let mockLocation = CLLocation(latitude: -23.5666151, longitude: -46.6463977)
        let locationStream = userLocationService.getUserLocation()
        
        locationStream.subscribe(onNext: { (location) in
            XCTAssertEqual(mockLocation, location)
        }, onError: { (_) in
            XCTFail("Should not return error")
        }).disposed(by: disposeBag)
        
        locationManager.delegate?.locationManager!(CLLocationManager(), didUpdateLocations: [mockLocation])
    }
    
    func testShouldReturnErrorIfLocationManagerFail() {
        let mockError = NSError(domain: "Mock error", code: 42, userInfo: nil)
        let locationStream = userLocationService.getUserLocation()
        
        locationStream.subscribe(onNext: { (_) in
            XCTFail("Should return error")
        }, onError: { (error) in
            XCTAssertEqual(mockError, error as NSError)
        }).disposed(by: disposeBag)
        
        locationManager.delegate?.locationManager!(CLLocationManager(), didFailWithError: mockError)
    }
}
