//
//  AppReducerSpec.swift
//  FoursquareTests
//
//  Created by Eduard Ani on 22/05/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import XCTest
import Swinject
import ReSwift

class AppReducerSpec: XCTestCase {
    
    private var container: Container!
    private var reducer: AppReducer!
    
    override func setUp() {
        super.setUp()
        
        setupDependencies()
    }
    
    func testShouldResolveDependencies() {
        XCTAssertNotNil(reducer)
    }
    
    func testShouldReturnInitialState() {
        let newState = reducer.reduce(action: FetchPlacesAction(), state: nil)
        XCTAssertEqual(newState, FetchedPlacesState(places: .loading))
    }
    
    func testShouldChangeStateAfterSuccessfulRequest() {
        let places = LocationPlaces()
        let action = SetPlacesAction(places: places)
        
        let newState = reducer.reduce(action: action, state: nil)
        XCTAssertEqual(newState, FetchedPlacesState(places: Result.finished(places)))
    }
    
    func testShouldChangeStateAfterErrorRequest() {
        let mockError = NSError(domain: "Mock error", code: 42, userInfo: nil )
        let action = SetErrorAction(error: mockError)
        
        let newState = reducer.reduce(action: action, state: nil)
        XCTAssertEqual(newState, FetchedPlacesState(places: Result.failed))
    }
    
    private func setupDependencies() {
        container = Container()
        container.register(UserLocationDataSource.self) { _ in UserLocationServiceMock() }
            .inObjectScope(.container)
        container.register(PlacesDataSource.self) { _ in PlacesApiMock() }
            .inObjectScope(.container)
        container.register(NearbyPlacesService.self) { resolver in
            NearbyPlacesService(userLocationDataSource: resolver.resolve(UserLocationDataSource.self)!,
                                placesDataSource: resolver.resolve(PlacesDataSource.self)!)}
        
        container.register(AppReducer.self) { resolver in
            AppReducer(resolver.resolve(NearbyPlacesService.self)!)
        }
        
        reducer = container.resolve(AppReducer.self)
    }
}
