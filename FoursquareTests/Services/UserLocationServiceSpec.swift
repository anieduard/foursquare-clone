//
//  UserLocationServiceSpec.swift
//  FoursquareTests
//
//  Created by Eduard Ani on 24/04/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import XCTest
import Swinject

class UserLocationServiceSpec: XCTestCase {
    
    var container: Container!
    
    override func setUp() {
        super.setUp()
        
        container = Container()
        container.register(LocationManager.self) { _ in LocationManagerMock() }
            .inObjectScope(.container) // One instance per container
        container.register(UserLocationService.self) { resolver in
            UserLocationService(locationManager: resolver.resolve(LocationManager.self)!)
        }
    }
    
    func testDependencyDelegateShouldBeWrapperClass() {
        let locationManager = container.resolve(LocationManager.self)!
        let userLocationService: UserLocationService = container.resolve(UserLocationService.self)!
        
        XCTAssertTrue(locationManager.delegate === userLocationService)
    }
    
    func testShouldRequestUserPermission() {
        guard let locationManager = container.resolve(LocationManager.self) as? LocationManagerMock else {
            XCTFail("Error resolving container dependencies")
            return
        }
        
        let userLocationService = container.resolve(UserLocationService.self)!
        
        XCTAssertFalse(locationManager.calledRequestWhenInUseAuthorization)
        _ = userLocationService.getUserLocation()
        XCTAssertTrue(locationManager.calledRequestWhenInUseAuthorization)
    }
}
